import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/controller/listen.dart';
import 'package:green_score/components/custom_card/custom_card.dart';
import 'package:green_score/components/history_card/history_card.dart';
import 'package:green_score/models/result.dart';
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
  Widget build(BuildContext context) {
    return isLoadingPage == true
        ? Center(
            child: CircularProgressIndicator(
              color: greentext,
            ),
          )
        : Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardList.rows?.length != 0
                      ? Container(
                          height: 220,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: cardList.rows!
                                .map(
                                  (data) => Row(
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
                                  ),
                                )
                                .toList(),
                          ),
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
                  Column(
                    children: ["1", "2", "3", "4"]
                        .map(
                          (e) => Column(
                            children: [
                              HistoryCard(),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
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
                    height: 90,
                  ),
                ],
              ),
            ),
          );
  }
}
