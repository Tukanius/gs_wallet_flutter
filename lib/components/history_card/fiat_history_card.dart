import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/history.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/utils/utils.dart';

class FiatHistoryCard extends StatefulWidget {
  final History data;
  const FiatHistoryCard({super.key, required this.data});

  @override
  State<FiatHistoryCard> createState() => _FiatHistoryCardState();
}

class _FiatHistoryCardState extends State<FiatHistoryCard> {
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
              SvgPicture.asset('assets/svg/mnt.svg'),
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
                      overflow: TextOverflow.ellipsis,
                      color: white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.data.totalAmount}',
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
            "${Utils().formatCurrency(widget.data.amount.toString())}₮",
            style: TextStyle(
              color: widget.data.type == "DEPOSIT" ? greentext : expenditure,
              overflow: TextOverflow.ellipsis,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
