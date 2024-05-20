import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/controller/listen.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/components/custom_card/custom_card.dart';
import 'package:green_score/components/refresher/refresher.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/src/profile_page/profile_page.dart';
import 'package:green_score/src/wallet_page/card_detail_page/card_detail_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WalletPage extends StatefulWidget {
  static const routeName = "WalletPage";
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with AfterLayoutMixin {
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  bool isLoadingPage = true;
  Result cardList = Result(rows: [], count: 0);
  Result getHistory = Result(rows: [], count: 0);

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool isSubmit = false;
  ListenController listenController = ListenController();
  @override
  void initState() {
    listenController.addListener(() async {
      await list(page, limit);
    });
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
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

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      limit = 10;
    });
    await list(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await list(page, limit);
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
                              height: 200,
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
                                        child: CustomCard(
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
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: 20),
                            //   child: Text(
                            //     'Данс холбох',
                            //     style: TextStyle(
                            //       color: white,
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 36),
                            //   width: MediaQuery.of(context).size.width,
                            //   height: 200,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(20),
                            //     color: buttonbg,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 200,
                            //   child: ListView.builder(
                            //     shrinkWrap: true,
                            //     itemCount: cardList.rows!.length,
                            //     scrollDirection: Axis.horizontal,
                            //     padding: EdgeInsets.symmetric(horizontal: 20),
                            //     itemBuilder: (context, index) {
                            //       final data = cardList.rows![index];
                            //       return Row(
                            //         children: [
                            //           GestureDetector(
                            //             onTap: () {
                            //               Navigator.of(context).pushNamed(
                            //                 CardDetailPage.routeName,
                            //                 arguments: CardDetailPageArguments(
                            //                     data: data),
                            //               );
                            //             },
                            //             child: CustomCard(
                            //               data: data,
                            //               isAll: true,
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             width: 16,
                            //           ),
                            //         ],
                            //       );
                            //     },
                            //   ),
                            // ),
                            // SingleChildScrollView(
                            //   scrollDirection: Axis.horizontal,
                            //   child: Row(
                            //     children: cardList.rows!
                            //         .map(
                            //           (data) => Row(
                            //             children: [
                            //               GestureDetector(
                            //                 onTap: () {
                            //                   Navigator.of(context).pushNamed(
                            //                     CardDetailPage.routeName,
                            //                     arguments:
                            //                         CardDetailPageArguments(
                            //                             data: data),
                            //                   );
                            //                 },
                            //                 child: CustomCard(
                            //                   data: data,
                            //                   isAll: true,
                            //                 ),
                            //               ),
                            //               SizedBox(
                            //                 height: 16,
                            //               ),
                            //               SizedBox(
                            //                 height: 160,
                            //               ),
                            //             ],
                            //           ),
                            //         )
                            //         .toList(),
                            //   ),
                            // ),
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
                              'Дан баталгаажуулалт хийгдээгүй байна.',
                              style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
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
                      )),
          );
  }
}
