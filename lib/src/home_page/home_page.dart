import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/product_api.dart';
import 'package:green_score/components/company_card/company_card.dart';
import 'package:green_score/components/refresher/refresher.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/src/home_page/company_page/company_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  static const routename = "HomePage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin {
  bool isLoading = true;
  bool isLoadingPage = true;
  int page = 1;
  int limit = 10;
  Result merchantList = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Timer? timer;
  bool isSubmit = false;
  afterFirstLayout(BuildContext context) async {
    await list(page, limit, '');
    setState(() {
      isLoading = false;
      isLoadingPage = false;
    });
  }

  list(page, limit, String value) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '', search: value);
    merchantList = await ProductApi()
        .getMerchant(ResultArguments(filter: filter, offset: offset));
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
    return isLoadingPage == true
        ? Center(
            child: CircularProgressIndicator(
              color: greentext,
            ),
          )
        : Refresher(
            refreshController: refreshController,
            onLoading: onLoading,
            onRefresh: onRefresh,
            color: greentext,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Хямдрал",
                      style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormTextField(
                      onChanged: (query) {
                        onChange(query);
                      },
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svg/search.svg'),
                        ],
                      ),
                      hintText: "Хайх",
                      colortext: white,
                      color: buttonbg,
                      name: "search",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    merchantList.rows?.length != null
                        ? Column(
                            children: merchantList.rows!
                                .map(
                                  (data) => Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: CompanyCard(
                                      data: data,
                                      onClick: () {
                                        Navigator.of(context).pushNamed(
                                          CompanyPage.routeName,
                                          arguments: CompanyPageArguments(
                                            data: data,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                                .toList())
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
                                  'Xямдрал олдсонгүй',
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
                    SizedBox(
                      height: 90,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
