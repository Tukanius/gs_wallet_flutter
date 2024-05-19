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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: buttonbg,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: widget.data.image != null
                        ? CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage('${widget.data.image}'),
                            backgroundColor: greytext,
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
                  Text(
                    '${widget.data.name}',
                    style: TextStyle(
                      color: white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat("yyyy-MM-dd HH:mm").format(
                  DateTime.parse(widget.data.createdAt!),
                ),
                style: TextStyle(
                  color: colortext,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
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
                    color: white, fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                '${widget.data.email}',
                style: TextStyle(
                    color: white, fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Утас:',
                style: TextStyle(
                    color: white, fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                '${widget.data.phone}',
                style: TextStyle(
                    color: white, fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Утас:',
                style: TextStyle(
                    color: white, fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                widget.data.phoneSecond != null
                    ? '${widget.data.phoneSecond}'
                    : '-',
                style: TextStyle(
                    color: white, fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Social хаяг',
                style: TextStyle(
                    color: white, fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Column(
                children: widget.data.links!
                    .map(
                      (data) => Text(
                        "${data.uri}",
                        style: TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          Text(
            widget.data.address != null
                ? 'Хаяг: ${widget.data.address} '
                : 'Хаяг: - ',
            style: TextStyle(
              color: white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 18),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: productList.rows?.length == 0
                ? isLoading == true
                    ? SizedBox()
                    : Center(
                        child: Text(
                          'Бараа бүртгэгдээгүй байна.',
                          style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                : ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
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
                                    borderRadius: BorderRadius.circular(14),
                                    color: greytext,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
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
          ),
          GestureDetector(
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
                    fontWeight: FontWeight.w400,
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
