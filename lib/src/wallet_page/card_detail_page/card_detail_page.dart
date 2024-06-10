import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/controller/listen.dart';
import 'package:green_score/components/account_card/account_card.dart';
import 'package:green_score/components/history_card/fiat_history_card.dart';
import 'package:green_score/components/history_card/token_history_card.dart';
import 'package:green_score/components/refresher/refresher.dart';
import 'package:green_score/models/account.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/src/wallet_page/card_detail_page/bottom_sheets/income_sheet.dart';
import 'package:green_score/utils/utils.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CardDetailPageArguments {
  Account data;

  CardDetailPageArguments({
    required this.data,
  });
}

class CardDetailPage extends StatefulWidget {
  final Account data;
  static const routeName = "CardDetailPage";
  const CardDetailPage({
    super.key,
    required this.data,
  });

  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> with AfterLayoutMixin {
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result bankList = Result(rows: [], count: 0);
  Result cardList = Result(rows: [], count: 0);
  ListenController listenController = ListenController();
  Account accountget = Account();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Timer? timer;
  bool isSubmit = false;
  @override
  void initState() {
    listenController.addListener(() async {
      await listHistory(page, limit);
    });
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await listHistory(page, limit);
    accountget = await WalletApi().getAccount(widget.data.id!);
    setState(() {
      isLoading = false;
    });
  }

  listHistory(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '', account: '${widget.data.id}');
    cardList = await WalletApi()
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

  comingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bg,
          content: Text(
            'Тун удахгүй!',
            style: TextStyle(
              color: white,
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  showDetail(context, data) {
    String createdDate = Utils.formatUTC8(data.createdAt!);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: MediaQuery.of(context).size.height * 0.40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
            color: white,
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: nfc,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(),
                  Text(
                    'Гүйлгээний дэлгэрэнгүй',
                    style: TextStyle(
                      color: black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: SvgPicture.asset('assets/svg/close.svg'),
                  // ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: greytext.withOpacity(0.2),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${data.description}:',
                    style: TextStyle(
                      color: greytext,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    data.type == "TOKEN"
                        ? '${data.totalAmount} GS'
                        : '${data.totalAmount}₮',
                    style: TextStyle(
                      color: greentext,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Огноо:',
                    style: TextStyle(
                      color: greytext,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${createdDate}',
                    style: TextStyle(
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // show(context, data) async {
  //   String createdDate = Utils.formatUTC8(data.createdAt!);
  //   showDialog(
  //     barrierDismissible: true,
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         alignment: Alignment.center,
  //         margin: const EdgeInsets.symmetric(horizontal: 20),
  //         child: Stack(
  //           alignment: Alignment.topCenter,
  //           children: <Widget>[
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 15),
  //               decoration: BoxDecoration(
  //                 color: bg,
  //                 borderRadius: BorderRadius.circular(16),
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   Container(
  //                     margin: const EdgeInsets.only(top: 30, bottom: 20),
  //                     child: Text(
  //                       'Гүйлгээний түүхийн дэлгэрэнгүй',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.w600,
  //                         color: white,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                   ),
  //                   Divider(color: white),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         '${data.description}',
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           color: white,
  //                           fontSize: 14,
  //                         ),
  //                       ),
  //                       Text(
  //                         // 'Урамшуулийн дүн',
  //                         data.type == "TOKEN"
  //                             ? '${data.totalAmount} GS'
  //                             : '${data.totalAmount}₮',
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           color: white,
  //                           fontSize: 14,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         'Огноо',
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           color: white,
  //                           fontSize: 14,
  //                         ),
  //                       ),
  //                       Text(
  //                         '${createdDate}',
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           color: white,
  //                           fontSize: 14,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 15,
  //                   ),
  //                   Divider(color: white),
  //                   ButtonBar(
  //                     buttonMinWidth: 100,
  //                     alignment: MainAxisAlignment.spaceEvenly,
  //                     children: <Widget>[
  //                       TextButton(
  //                         style: ButtonStyle(
  //                           overlayColor:
  //                               MaterialStateProperty.all(Colors.transparent),
  //                         ),
  //                         child: Text(
  //                           "Болсон",
  //                           style: TextStyle(
  //                             color: white,
  //                           ),
  //                         ),
  //                         onPressed: () {
  //                           Navigator.of(context).pop();
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

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
                'Картын дэлгэрэнгүй',
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
                refreshController: refreshController,
                onRefresh: onRefresh,
                onLoading: onLoading,
                color: greentext,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AccountCard(
                          data: widget.data,
                          isAll: false,
                        ),
                        accountget.type == "FIAT"
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                income(context, accountget.id!);
                                              },
                                              child: Container(
                                                height: 52,
                                                width: 52,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: buttonbg,
                                                ),
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    'assets/svg/income.svg',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Орлого',
                                              style: TextStyle(
                                                color: white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Column(
                                      //     children: [
                                      //       GestureDetector(
                                      //         onTap: () {
                                      //           comingSoon(context);
                                      //           // income(context, accountget.id!);
                                      //         },
                                      //         child: Container(
                                      //           height: 52,
                                      //           width: 52,
                                      //           decoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(16),
                                      //             color: buttonbg,
                                      //           ),
                                      //           child: Center(
                                      //             child: SvgPicture.asset(
                                      //                 'assets/svg/income1.svg'),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         height: 10,
                                      //       ),
                                      //       Text(
                                      //         'Татах',
                                      //         style: TextStyle(
                                      //           color: white,
                                      //           fontSize: 14,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
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
                        cardList.rows?.length != 0
                            ? Column(
                                children: cardList.rows!
                                    .map(
                                      (data) => Column(
                                        children: [
                                          widget.data.type == "TOKEN"
                                              ? TokenHistoryCard(
                                                  data: data,
                                                )
                                              : widget.data.type == "FIAT"
                                                  ? FiatHistoryCard(
                                                      data: data,
                                                    )
                                                  : SizedBox(),
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
                                    SizedBox(
                                      height: 80,
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
