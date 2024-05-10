import 'package:flutter/material.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/score_opportunities_card/opportunity_card.dart';
import 'package:green_score/src/collect_score_page/opportunity_status_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';

class AllOpportunityPage extends StatefulWidget {
  static const routeName = "AllOpportunityPage";
  const AllOpportunityPage({super.key});

  @override
  State<AllOpportunityPage> createState() => _AllOpportunityPageState();
}

class _AllOpportunityPageState extends State<AllOpportunityPage> {
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
                        assetPath: 'assets/svg/bus.svg',
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
                OpportunityCard(
                  id: "5",
                  assetPath: 'assets/svg/scooter.svg',
                  title: 'Скүүтэр',
                  subtitle: '5000төг = 1GS',
                  onClick: () {
                    Navigator.of(context).pushNamed(
                      OpportunityStatusPage.routeName,
                      arguments: OpportunityStatusPageArguments(
                        id: "5",
                        title: "Скүүтэр",
                        assetPath: 'assets/svg/scooter.svg',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
