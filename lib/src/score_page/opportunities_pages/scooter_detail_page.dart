import 'package:after_layout/after_layout.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_score/api/score_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/history_card/scooter_history_card.dart';
import 'package:green_score/components/score_status_card/scooter_status_card.dart';
import 'package:green_score/models/accumlation.dart';
import 'package:green_score/models/result.dart';
// import 'package:green_score/components/history_card/fiat_history_card.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:intl/intl.dart';

class ScooterDetailPageArguments {
  String title;
  String assetPath;

  ScooterDetailPageArguments({
    required this.title,
    required this.assetPath,
  });
}

class ScooterDetailPage extends StatefulWidget {
  final String title;
  final String assetPath;

  static const routeName = "ScooterDetailPage";
  const ScooterDetailPage({
    super.key,
    required this.title,
    required this.assetPath,
  });

  @override
  State<ScooterDetailPage> createState() => _ScooterDetailPageState();
}

class _ScooterDetailPageState extends State<ScooterDetailPage>
    with AfterLayoutMixin {
  bool isLoading = false;
  int _selectedIndex = 0;
  DateTime? startDate;
  DateTime? endDate;
  String? datestart;
  String? dateend;
  int page = 1;
  int limit = 10;
  Result scooterHistory = Result(rows: [], count: 0);
  Accumlation scooter = Accumlation();
  @override
  afterFirstLayout(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      scooter.type = "COMMUNITY";
      scooter.code = "SCOOTER_01";
      scooter = await ScoreApi().getStep(scooter);

      print('=======+TEST=======');
      print(
        DateFormat('yyyy-MM-dd')
            .format(
              DateTime.now(),
            )
            .toString(),
      );
      await list(
        page,
        limit,
        DateFormat('yyyy-MM-dd')
            .format(
              DateTime.now(),
            )
            .toString(),
        DateFormat('yyyy-MM-dd')
            .format(
              DateTime.now(),
            )
            .toString(),
      );
      print(scooter.id);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onButtonTapped(int index, String day) async {
    setState(() {
      endDate = null;
      startDate = null;
      datestart = null;
      dateend = null;
    });
    DateTime now = DateTime.now();
    String buttonStartDate = now.toString(), buttonEndDate = now.toString();
    try {
      setState(() {
        isLoading = true;
      });
      if (day == "TODAY") {
        buttonStartDate = DateFormat('yyyy-MM-dd').format(now);
        buttonEndDate = buttonStartDate;
      } else if (day == "7DAYS") {
        buttonStartDate =
            DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 7)));
        buttonEndDate = DateFormat('yyyy-MM-dd').format(now);
      } else if (day == "1MONTH") {
        DateTime thirtyDaysAgo = now.subtract(Duration(days: 30));
        buttonStartDate = DateFormat('yyyy-MM-dd').format(thirtyDaysAgo);
        buttonEndDate = DateFormat('yyyy-MM-dd').format(now);
      }

      await list(page, limit, buttonStartDate, buttonEndDate);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  list(page, limit, String startDate, String endDate) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(
      accumlationId: '${scooter.id}',
      endDate: endDate,
      startDate: startDate,
    );
    scooterHistory = await ScoreApi().getStepHistory(
      ResultArguments(filter: filter, offset: offset),
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
          return <Widget>[
            SliverAppBar(
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              pinned: false,
              snap: true,
              floating: true,
              elevation: 0,
              backgroundColor: transparent,
              leading: CustomBackButton(
                onClick: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              title: Text(
                '${widget.title}',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScooterStatusCard(
                  assetPath: "${widget.assetPath}",
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    showCustomDateRangePicker(
                      context,
                      dismissible: true,
                      startDate: startDate,
                      endDate: endDate,
                      minimumDate: DateTime.now().subtract(
                        const Duration(days: 90),
                      ),
                      maximumDate: DateTime.now(),
                      onApplyClick: (start, end) {
                        setState(() {
                          _selectedIndex = 4;
                          startDate = start;
                          endDate = end;
                          datestart =
                              DateFormat('yyyy-MM-dd').format(startDate!);
                          dateend = DateFormat('yyyy-MM-dd').format(endDate!);
                          isLoading = true;
                        });
                        list(page, limit, datestart!, dateend!).then((_) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      onCancelClick: () {
                        setState(() {
                          endDate = null;
                          startDate = null;
                          datestart = null;
                          dateend = null;
                        });
                      },
                      backgroundColor: Theme.of(context).colorScheme.background,
                      primaryColor: greentext,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: buttonbg,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/calendar.svg'),
                        SizedBox(
                          width: 10,
                        ),
                        datestart == null
                            ? Text(
                                DateFormat('yyyy-MM-dd').format(
                                  DateTime.now(),
                                ),
                                style: TextStyle(
                                  color: greytext,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : Text(
                                '${datestart}',
                                style: TextStyle(
                                  color: greytext,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            color: greytext,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset('assets/svg/calendar.svg'),
                        SizedBox(
                          width: 10,
                        ),
                        dateend == null
                            ? Text(
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                style: TextStyle(
                                  color: greytext,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            : Text(
                                '${dateend}',
                                style: TextStyle(
                                  color: greytext,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: buttonbg,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _onButtonTapped(0, "TODAY"),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: _selectedIndex == 4
                                  ? transparent
                                  : _selectedIndex == 0
                                      ? greentext
                                      : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Өнөөдөр',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 16,
                        width: 1,
                        color: greytext,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _onButtonTapped(1, "7DAYS"),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: _selectedIndex == 4
                                  ? transparent
                                  : _selectedIndex == 1
                                      ? greentext
                                      : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                '7 хоног',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 16,
                        width: 1,
                        color: greytext,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _onButtonTapped(2, "1MONTH"),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: _selectedIndex == 4
                                  ? transparent
                                  : _selectedIndex == 2
                                      ? greentext
                                      : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Сар',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Түүх',
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: greentext,
                        ),
                      )
                    : scooterHistory.rows!.isNotEmpty
                        ? Column(
                            children: scooterHistory.rows!
                                .map(
                                  (data) => Column(
                                    children: [
                                      ScooterHistoryCard(
                                        data: data,
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Divider(
                                          color: white.withOpacity(0.1),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          )
                        : Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                ),
                                SvgPicture.asset(
                                  'assets/svg/notfound.svg',
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  '${widget.title}',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Түүх алга байна.',
                                  style: TextStyle(
                                    color: greytext,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                              ],
                            ),
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
