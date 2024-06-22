import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/user_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/controller/listen.dart';
import 'package:green_score/components/notification_card/notification_card.dart';
import 'package:green_score/components/refresher/refresher.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/sale_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/scooter_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/step_detail_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:green_score/models/result.dart';

class NotificationPage extends StatefulWidget {
  static const routeName = "NotificationPage";
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with AfterLayoutMixin {
  ListenController listenController = ListenController();
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result notifyList = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    listenController.addListener(() async {
      await list(page, limit, '');
      listenController.refreshList("refresh");
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit, '');
  }

  list(page, limit, String value) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(
      query: '',
    );
    notifyList = await UserApi()
        .getNotification(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      limit = 10;
    });
    await list(page, limit, '');
    refreshController.refreshCompleted();
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit, '');
    refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
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
                'Мэдэгдэл',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ];
        },
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: greentext,
                ),
              )
            : Refresher(
                color: greentext,
                refreshController: refreshController,
                onLoading: onLoading,
                onRefresh: onRefresh,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        notifyList.rows!.isNotEmpty
                            ? Column(
                                children: notifyList.rows!
                                    .map(
                                      (data) => Column(
                                        children: [
                                          NotificationCard(
                                            data: data,
                                            onClick: () async {
                                              var res = await UserApi()
                                                  .seenNot(data.id);
                                              print('===CLICKED===');
                                              print(res);
                                              print('===CLICKED===');

                                              data.type == "ORDER_SUCCESS"
                                                  ? Navigator.of(context)
                                                      .pushNamed(
                                                      SaleDetailPage.routeName,
                                                      arguments:
                                                          SaleDetailPageArguments(
                                                        title: "Худалдан авалт",
                                                        assetPath:
                                                            'assets/svg/bag.svg',
                                                      ),
                                                    )
                                                  : data.type ==
                                                          "SCOOTER_ACCUMLATE"
                                                      ? Navigator.of(context)
                                                          .pushNamed(
                                                          ScooterDetailPage
                                                              .routeName,
                                                          arguments:
                                                              ScooterDetailPageArguments(
                                                            title: "Скүүтер",
                                                            assetPath:
                                                                'assets/svg/scooter.svg',
                                                          ),
                                                        )
                                                      : data.type ==
                                                              "WALK_ACCUMLATE"
                                                          ? Navigator.of(
                                                                  context)
                                                              .pushNamed(
                                                              StepDetailPage
                                                                  .routeName,
                                                              arguments:
                                                                  StepDetailPageArguments(
                                                                title: "Алхалт",
                                                                assetPath:
                                                                    'assets/svg/man.svg',
                                                              ),
                                                            )
                                                          : data.type ==
                                                                  "REDEEM"
                                                              ? Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      MainPage
                                                                          .routeName)
                                                              : Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      MainPage
                                                                          .routeName);

                                              // Navigator.of(context).pushNamed(
                                              //   NotificationDetailPage.routeName,
                                              //   arguments:
                                              //       NotificationDetailPageArguments(
                                              //     listenController: listenController,
                                              //     data: data,
                                              //   ),
                                              // );
                                            },
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              )
                            : Column(
                                children: [
                                  Center(
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
                                          'Мэдэгдэл хоосон байна.',
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 80,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
