import 'package:flutter/material.dart';
import 'package:green_score/components/opportunity_card/opportunity_card.dart';
import 'package:green_score/components/score_status_card/step_status_card.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/tools_provider.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/score_page/all_opportunity_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/autobus_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/sale_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/school_card_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/scooter_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/step_detail_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:provider/provider.dart';

class ScorePage extends StatefulWidget {
  static const routeName = "ScorePage";
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  User user = User();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    var tool = Provider.of<ToolsProvider>(context, listen: true);

    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Өдрийн мэнд!',
              style: TextStyle(
                color: colortext,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(
                color: white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StepStatusCard(
              assetPath: "assets/svg/man.svg",
              isActive: true,
              pushWhere: "MAIN",
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Бусад боломжууд',
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AllOpportunityPage.routeName);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: greentext,
                    ),
                    child: Center(
                      child: Text(
                        'Бүгд',
                        style: TextStyle(
                          color: white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            OpportunityCard(
              assetPath: 'assets/svg/man.svg',
              title: 'Алхалт',
              subtitle: '${tool.walkDescription}',
              onClick: () {
                Navigator.of(context).pushNamed(
                  StepDetailPage.routeName,
                  arguments: StepDetailPageArguments(
                    title: "Алхалт",
                    assetPath: 'assets/svg/man.svg',
                  ),
                );
              },
            ),
            OpportunityCard(
              assetPath: 'assets/svg/scooter.svg',
              title: 'Скүүтер',
              subtitle: '${tool.scooterDescription}',
              onClick: () {
                Navigator.of(context).pushNamed(
                  ScooterDetailPage.routeName,
                  arguments: ScooterDetailPageArguments(
                    title: "Скүүтер",
                    assetPath: 'assets/svg/scooter.svg',
                  ),
                );
              },
            ),
            OpportunityCard(
              assetPath: 'assets/svg/bus.svg',
              title: 'Автобус',
              subtitle: '10км = 1GS',
              onClick: () {
                Navigator.of(context).pushNamed(
                  AutobusDetailPage.routeName,
                  arguments: AutobusDetailPageArguments(
                    title: "Автобус",
                    assetPath: "assets/svg/bus.svg",
                  ),
                );
              },
            ),
            OpportunityCard(
              assetPath: 'assets/svg/bag.svg',
              title: 'Худалдан авалт',
              subtitle: '5000төг = 1GS',
              onClick: () {
                Navigator.of(context).pushNamed(
                  SaleDetailPage.routeName,
                  arguments: SaleDetailPageArguments(
                    title: "Худалдан авалт",
                    assetPath: 'assets/svg/bag.svg',
                  ),
                );
              },
            ),
            OpportunityCard(
              assetPath: 'assets/svg/schoolcard.svg',
              title: 'Сургуулийн карт',
              subtitle: '5000төг = 1GS',
              onClick: () {
                Navigator.of(context).pushNamed(
                  SchoolCardPage.routeName,
                  arguments: SchoolCardPageArguments(
                    title: "Сургуулийн карт",
                    assetPath: 'assets/svg/schoolcard.svg',
                  ),
                );
              },
            ),
            // OpportunityCard(
            //   id: "3",
            //   assetPath: 'assets/svg/bicycle.svg',
            //   title: 'Унадаг дугуй',
            //   subtitle: '3км = 1GS',
            //   onClick: () {
            //     Navigator.of(context).pushNamed(
            //       OpportunityStatusPage.routeName,
            //       arguments: OpportunityStatusPageArguments(
            //         id: "3",
            //         title: "Унадаг дугуй",
            //         assetPath: 'assets/svg/bicycle.svg',
            //       ),
            //     );
            //   },
            // ),
            SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}
