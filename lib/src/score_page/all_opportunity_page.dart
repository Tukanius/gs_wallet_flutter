import 'package:flutter/material.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/opportunity_card/opportunity_card.dart';
import 'package:green_score/src/score_page/opportunities_pages/autobus_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/sale_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/school_card_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/scooter_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/step_detail_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';

class AllOpportunityPage extends StatefulWidget {
  static const routeName = "AllOpportunityPage";
  const AllOpportunityPage({super.key});

  @override
  State<AllOpportunityPage> createState() => _AllOpportunityPageState();
}

class _AllOpportunityPageState extends State<AllOpportunityPage> {
  comingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bg,
          content: Text(
            'Тун удахгүй!',
            style: TextStyle(
              color: white,
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ],
        );
      },
    );
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
              leading: CustomBackButton(
                onClick: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              title: Text(
                'Бүх боломжууд',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                OpportunityCard(
                  assetPath: 'assets/svg/man.svg',
                  title: 'Алхалт',
                  subtitle: '1км = 1GS',
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
                  subtitle: '5000төг = 1GS',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
