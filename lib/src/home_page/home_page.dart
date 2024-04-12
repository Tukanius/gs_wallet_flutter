import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/customer_api.dart';
import 'package:green_score/components/company_card/company_card.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/src/home_page/company_page/company_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';

class HomePage extends StatefulWidget {
  static const routename = "HomePage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin {
  List<String> qwe = [
    'https://officebanao.com/wp-content/uploads/2022/10/Modern-office-design-5-1024x576.jpg',
    'https://officebanao.com/wp-content/uploads/2022/10/Modern-office-design-5-1024x576.jpg',
    'https://officebanao.com/wp-content/uploads/2022/10/Modern-office-design-5-1024x576.jpg',
    'https://officebanao.com/wp-content/uploads/2022/10/Modern-office-design-5-1024x576.jpg',
  ];
  bool isLoading = true;
  int page = 1;
  int limit = 10;
  Result merchantList = Result(rows: [], count: 0);

  afterFirstLayout(BuildContext context) {
    list(page, limit);
  }

  list(page, limit) async {
    setState(() {
      isLoading = true;
    });
    Offset offset = Offset(page: page, limit: limit);
    Filter filter = Filter(query: '');
    merchantList = await CustomerApi()
        .merchantList(ResultArguments(filter: filter, offset: offset));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
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
                          (e) => Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: CompanyCard(
                              profileUrl:
                                  "https://officebanao.com/wp-content/uploads/2022/10/Modern-office-design-5-1024x576.jpg",
                              name: e.name,
                              createdDate: e.createdAt,
                              products: qwe,
                              onClick: () {
                                Navigator.of(context).pushNamed(
                                  CompanyPage.routeName,
                                  arguments: CompanyPageArguments(
                                    name: e.name,
                                    id: e.id,
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
    );
  }
}
