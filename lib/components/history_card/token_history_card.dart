import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/history.dart';
import 'package:green_score/utils/utils.dart';
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
    String createdDate = Utils.formatUTC8(widget.data.createdAt!);

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
                    createdDate,
                    style: TextStyle(
                      color: white,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '${widget.data.description}',
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.data.totalAmount} GS',
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
            '${widget.data.totalAmount} GS',
            style: TextStyle(
              color: widget.data.type == "DEPOSIT" ? greentext : expenditure,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
