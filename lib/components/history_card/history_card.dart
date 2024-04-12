import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/widget/ui/color.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({super.key});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
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
              // SvgPicture.asset('assets/svg/mnt.svg'),
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
                    // 'GSC - Орлого',
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Үлдэгдэл: 365 GS',
                    // 'Үлдэгдэл: ₮135,000.00',
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
            // '₮50,000.00',
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
