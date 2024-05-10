import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/controller/listen.dart';
import 'package:green_score/components/custom_card/custom_card.dart';
import 'package:green_score/components/history_card/fiat_history_card.dart';
import 'package:green_score/components/history_card/token_history_card.dart';
import 'package:green_score/components/refresher/refresher.dart';
import 'package:green_score/models/account.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/src/wallet_page/card_detail_page/bottom_sheets/income_sheet.dart';
import 'package:green_score/src/wallet_page/card_detail_page/bottom_sheets/transfer_sheet.dart';
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
              leading: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CustomBackButton(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
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
              actions: [
                SvgPicture.asset('assets/svg/more.svg'),
                SizedBox(
                  width: 10,
                ),
              ],
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
                        CustomCard(data: widget.data, isAll: false),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        borderRadius: BorderRadius.circular(16),
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
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 52,
                                    width: 52,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: buttonbg,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                          'assets/svg/income1.svg'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Татах',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      transfer(context);
                                    },
                                    child: Container(
                                      height: 52,
                                      width: 52,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: buttonbg,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          width: 24,
                                          height: 24,
                                          'assets/svg/transfer.svg',
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Шилжүүлэг',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                            : Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    'Түүх алга байна.',
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 80,
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
