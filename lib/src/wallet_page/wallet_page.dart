import 'package:flutter/material.dart';
import 'package:green_score/components/custom_card/custom_card.dart';
import 'package:green_score/components/history_card/history_card.dart';
import 'package:green_score/src/wallet_page/card_detail_page/card_detail_page.dart';
import 'package:green_score/widget/ui/color.dart';

class WalletPage extends StatefulWidget {
  static const routeName = "WalletPage";
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: ["1", "2"]
                    .map(
                      (e) => Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                CardDetailPage.routeName,
                                arguments:
                                    CardDetailPageArguments(id: e, title: e),
                              );
                            },
                            child: CustomCard(
                              id: e,
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
            ),
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
