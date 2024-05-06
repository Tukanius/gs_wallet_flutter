import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_card/custom_card.dart';
import 'package:green_score/components/history_card/history_card.dart';
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
  Account accountget = Account();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Timer? timer;
  bool isSubmit = false;

  afterFirstLayout(BuildContext context) async {
    list(page, limit, '');
    accountget = await WalletApi().getAccount(widget.data.id!);
    setState(() {
      isLoading = false;
    });
  }

  list(page, limit, String query) async {
    setState(() {
      isLoading = true;
    });
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

  onChange(String query) {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isSubmit = true;
      });
      list(page, limit, query);
      setState(() {
        isSubmit = false;
      });
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
                        Column(
                          children: ["1", "2", "3", "4"]
                              .map(
                                (e) => Column(
                                  children: [
                                    HistoryCard(),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Divider(
                                        color: white.withOpacity(0.1),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
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
