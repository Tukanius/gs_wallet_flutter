import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/widget/ui/color.dart';

class TradeHistoryCard extends StatefulWidget {
  final bool inCome;
  const TradeHistoryCard({
    super.key,
    required this.inCome,
  });

  @override
  State<TradeHistoryCard> createState() => _TradeHistoryCardState();
}

class _TradeHistoryCardState extends State<TradeHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.inCome == true
                  ? SvgPicture.asset('assets/svg/buy.svg')
                  : SvgPicture.asset('assets/svg/sell.svg'),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2024.04.03',
                    style: TextStyle(
                      color: white,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    widget.inCome == true ? 'Авсан' : "Зарсан",
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Нийт: 7,630.43',
                    style: TextStyle(
                      color: white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Амжилттай',
                style: TextStyle(
                  color: white,
                  fontSize: 13,
                ),
              ),
              Text(
                '5,000 GS',
                style: TextStyle(
                  color: widget.inCome == true ? greentext : red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
