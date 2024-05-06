import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/product_api.dart';
import 'package:green_score/components/product_card/product_card.dart';
import 'package:green_score/components/refresher/refresher.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/src/home_page/product_detail_page/product_detail_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MerchantProduct extends StatefulWidget {
  final String id;
  const MerchantProduct({super.key, required this.id});

  @override
  State<MerchantProduct> createState() => _MerchantProductState();
}

class _MerchantProductState extends State<MerchantProduct>
    with AfterLayoutMixin {
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result productList = Result(rows: [], count: 0);
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  afterFirstLayout(BuildContext context) async {
    print('====HELLOFROMMERCHANTPRO======');
    await list(page, limit);
    setState(() {
      isLoading = false;
    });
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(merchant: widget.id);
    productList = await ProductApi()
        .getProduct(ResultArguments(filter: filter, offset: offset));
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
    return isLoading == true
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
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('Helloooo');
                      },
                      child: Text(
                        "Бүх бараа",
                        style: TextStyle(
                          color: white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FormTextField(
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
                      height: 15,
                    ),
                    productList.rows != null
                        ? GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15,
                            childAspectRatio: 3 / 4,
                            padding: EdgeInsets.all(0),
                            physics: NeverScrollableScrollPhysics(),
                            children: productList.rows!
                                .map(
                                  (data) => ProductCard(
                                    data: data,
                                    onClick: () {
                                      Navigator.of(context).pushNamed(
                                        ProductDetail.routeName,
                                        arguments: ProductDetailArguments(
                                          data: data,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: Text(
                                  'Бүртгэлтэй бараа олдсонгүй',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
