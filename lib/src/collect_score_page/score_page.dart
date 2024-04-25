import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_score/api/bonus_api.dart';
import 'package:green_score/components/score_opportunities_card/opportunity_card.dart';
import 'package:green_score/components/score_status_card/score_status_card.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
// import 'package:green_score/components/score_status_card/score_test.dart';
import 'package:green_score/src/collect_score_page/all_opportunity_page.dart';
import 'package:green_score/src/collect_score_page/opportunity_status_page.dart';
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

  onSubmit() async {
    await BonusApi().putBonus(user);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
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
              'Мөнхтуул Алтантулга',
              style: TextStyle(
                color: white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: onSubmit,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: greentext,
                ),
                child: Center(
                    child: Text(
                  'Оноо явуулах 100',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                  ),
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ScoreStatusCard(
              assetPath: "assets/svg/man.svg",
              isActive: true,
            ),
            // ScoreTest(),
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
              id: "1",
              assetPath: 'assets/svg/bus.svg',
              title: 'Автобус',
              subtitle: '10км = 1GS',
              onClick: () {
                Navigator.of(context).pushNamed(
                  OpportunityStatusPage.routeName,
                  arguments: OpportunityStatusPageArguments(
                    id: "1",
                    title: "Автобус",
                    assetPath: "assets/svg/bus.svg",
                  ),
                );
              },
            ),
            OpportunityCard(
              id: "2",
              assetPath: 'assets/svg/man.svg',
              title: 'Алхалт',
              subtitle: '1км = 1GS',
              onClick: () {
                Navigator.of(context).pushNamed(
                  OpportunityStatusPage.routeName,
                  arguments: OpportunityStatusPageArguments(
                    id: "2",
                    title: "Алхалт",
                    assetPath: 'assets/svg/man.svg',
                  ),
                );
              },
            ),
            OpportunityCard(
              id: "3",
              assetPath: 'assets/svg/bicycle.svg',
              title: 'Унадаг дугуй',
              subtitle: '3км = 1GS',
              onClick: () {
                Navigator.of(context).pushNamed(
                  OpportunityStatusPage.routeName,
                  arguments: OpportunityStatusPageArguments(
                    id: "3",
                    title: "Унадаг дугуй",
                    assetPath: 'assets/svg/bicycle.svg',
                  ),
                );
              },
            ),
            OpportunityCard(
              id: "4",
              assetPath: 'assets/svg/bag.svg',
              title: 'Худалдан авалт',
              subtitle: '5000төг = 1GS',
              onClick: () {
                Navigator.of(context).pushNamed(
                  OpportunityStatusPage.routeName,
                  arguments: OpportunityStatusPageArguments(
                    id: "4",
                    title: "Худалдан авалт",
                    assetPath: 'assets/svg/bag.svg',
                  ),
                );
              },
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