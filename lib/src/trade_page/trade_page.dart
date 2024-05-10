import 'package:flutter/material.dart';
import 'package:green_score/components/history_card/trade_history_card.dart';
import 'package:green_score/src/trade_page/candle_stick.dart';
import 'package:green_score/widget/ui/color.dart';

class TradePage extends StatefulWidget {
  static const routeName = "TradePage";
  const TradePage({super.key});

  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GSP/MNT',
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '0,4.00',
                          style: TextStyle(
                            color: greentext,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(58),
                            color: greentext,
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Center(
                              child: Text(
                                '1.76%',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              '24цаг High',
                              style: TextStyle(
                                color: greytext,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              '0,5.00',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              '24цаг Low',
                              style: TextStyle(
                                color: greytext,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              '0,35.40',
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 6,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CandleStick(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Гүйлгээний түүх',
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [true, false, false, true]
                  .map(
                    (e) => Column(
                      children: [
                        TradeHistoryCard(
                          inCome: e,
                        ),
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
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
