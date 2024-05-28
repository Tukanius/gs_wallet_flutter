import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/controller/listen.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/components/custom_cards/walking_card.dart';
import 'package:green_score/components/history_card/token_history_card.dart';
import 'package:green_score/components/refresher/refresher.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/profile_page/profile_page.dart';
import 'package:green_score/src/wallet_page/card_detail_page/card_detail_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletPage extends StatefulWidget {
  static const routeName = "WalletPage";
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with AfterLayoutMixin {
  int page = 1;
  int limit = 10;
  bool isLoading = true;
  bool isLoadingPage = true;
  Result cardList = Result(rows: [], count: 0);
  Result getHistory = Result(rows: [], count: 0);
  ListenController listenController = ListenController();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  User user = User();
  @override
  void initState() {
    listenController.addListener(() async {
      await list(page, limit);
    });
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    user = Provider.of<UserProvider>(context, listen: false).user;
    if (user.danVerified == false) {
      setState(() {
        isLoadingPage = false;
      });
    } else {
      await list(page, limit);
      await listHistory(page, limit);
    }
    setState(() {
      isLoading = false;
      isLoadingPage = false;
    });
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    cardList = await WalletApi()
        .getWalletList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  listHistory(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '', account: '${cardList.rows?.first.id}');
    getHistory = await WalletApi()
        .walletHistory(ResultArguments(filter: filter, offset: offset));
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
    await list(page, limit);
    await listHistory(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await listHistory(page, limit);
    refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingPage == true
        ? Center(
            child: CircularProgressIndicator(
              color: greentext,
            ),
          )
        : Refresher(
            color: greentext,
            refreshController: refreshController,
            onRefresh: onRefresh,
            onLoading: onLoading,
            child: SingleChildScrollView(
              child: cardList.rows!.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Үндсэн данс',
                              style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 220,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cardList.rows!.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              itemBuilder: (context, index) {
                                final data = cardList.rows![index];
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          CardDetailPage.routeName,
                                          arguments: CardDetailPageArguments(
                                              data: data),
                                        );
                                      },
                                      child: WalkingCard(
                                        data: data,
                                        isAll: true,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Гүйлгээний түүх',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                getHistory.rows!.isNotEmpty
                                    ? Column(
                                        children: getHistory.rows!
                                            .map(
                                              (data) => Column(
                                                children: [
                                                  // data.type == "TOKEN"
                                                  //     ?
                                                  TokenHistoryCard(
                                                    data: data,
                                                  ),
                                                  // : data.type == "FIAT"
                                                  //     ? FiatHistoryCard(
                                                  //         data: data,
                                                  //       )
                                                  //     : SizedBox(),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      vertical: 10,
                                                    ),
                                                    child: Divider(
                                                      color: white
                                                          .withOpacity(0.1),
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
                                              height: 60,
                                            ),
                                            SvgPicture.asset(
                                              'assets/svg/notfound.svg',
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'Түүх',
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
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            'Дан баталгаажуулалт хийгдээгүй байна. Та дан баталгаажуулалт хийснээр урамшууллаа цуглуулах боломжтой болно.',
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                            buttonColor: greentext,
                            height: 40,
                            isLoading: false,
                            labelText: "Баталгаажуулах",
                            onClick: () {
                              Navigator.of(context)
                                  .pushNamed(ProfilePage.routeName);
                            },
                            textColor: white,
                          ),
                        ],
                      ),
                    ),
            ),
          );
  }
}
