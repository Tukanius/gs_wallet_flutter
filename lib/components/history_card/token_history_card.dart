import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/history.dart';
import 'package:green_score/widget/ui/color.dart';

class TokenHistoryCard extends StatefulWidget {
  final History data;
  const TokenHistoryCard({super.key, required this.data});

  @override
  State<TokenHistoryCard> createState() => _TokenHistoryCardState();
}

class _TokenHistoryCardState extends State<TokenHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/svg/gsc.svg'),
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
                    '13км',
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Үлдэгдэл: 365 GS',
                    style: TextStyle(
                      color: white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '1.3 GS Бонус',
            style: TextStyle(
              color: greentext,
              // color: expenditure,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
