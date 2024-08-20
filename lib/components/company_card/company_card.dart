import 'package:after_layout/after_layout.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/product_api.dart';
import 'package:green_score/models/merchant.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/src/home_page/product_detail_page/product_detail_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:intl/intl.dart';
import 'package:green_score/components/company_card/product_image_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CompanyCard extends StatefulWidget {
  final Merchant data;
  final Function()? onClick;
  const CompanyCard({
    super.key,
    this.onClick,
    required this.data,
  });

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> with AfterLayoutMixin {
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result productList = Result(rows: [], count: 0);

  afterFirstLayout(BuildContext context) async {
    await list(page, limit);
  }

  @override
  void dispose() {
    super.dispose();
  }

  list(page, limit) async {
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(merchant: widget.data.id);
    productList = await ProductApi()
        .getProduct(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: buttonbg,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: widget.data.image != null
                          ? CircleAvatar(
                              radius: 20,
                              backgroundColor: greytext,
                              child: BlurHash(
                                color: greytext,
                                hash: '${widget.data.image?.blurhash}',
                                image: '${widget.data.image?.url}',
                                imageFit: BoxFit.cover,
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/svg/avatar.svg',
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        '${widget.data.name}',
                        style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd HH:mm").format(
                        DateTime.parse(widget.data.createdAt!),
                      ),
                      style: TextStyle(
                        color: colortext,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'И-мэйл:',
                      style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${widget.data.email}',
                      style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Утас:',
                      style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${widget.data.phone}',
                      style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Утас 2:',
                      style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.data.phoneSecond != null
                          ? '${widget.data.phoneSecond}'
                          : '-',
                      style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Social хаяг',
                      style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    // Container(
                    //   height: 45,
                    //   child: ListView(
                    //     shrinkWrap: true,
                    //     scrollDirection: Axis.horizontal,
                    //   ),
                    // ),
                    Row(
                      children: widget.data.links!
                          .map(
                            (data) => Row(
                              children: [
                                data.type != "XOT"
                                    ? GestureDetector(
                                        onTap: () => _launchURL(data.uri!),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                            data.type == "FACEBOOK"
                                                ? 'assets/images/fb.png'
                                                : data.type == "INSTAGRAM"
                                                    ? 'assets/images/ig.png'
                                                    : data.type == "TWITTER"
                                                        ? 'assets/images/x.png'
                                                        : 'assets/images/fb.png',
                                            height: 45,
                                            width: 45,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.data.address != null
                      ? 'Хаяг: ${widget.data.address} '
                      : 'Хаяг: - ',
                  style: TextStyle(
                    color: white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                DottedLine(
                  dashColor: colortext.withOpacity(0.5),
                  dashLength: 10,
                  dashGapLength: 10,
                  lineThickness: 1,
                ),
              ],
            ),
          ),
          productList.rows!.isNotEmpty
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 18),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: isLoading == true
                      ? SizedBox(
                          height: 100,
                        )
                      : ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          children: productList.rows!
                              .map(
                                (data) => Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          ProductDetail.routeName,
                                          arguments: ProductDetailArguments(
                                            data: data,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: greytext,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          child: ImageCard(
                                            data: data,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: widget.onClick,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: buttonbg,
                ),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Center(
                  child: Text(
                    'Дэлгэрэнгүй',
                    style: TextStyle(
                      color: white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
