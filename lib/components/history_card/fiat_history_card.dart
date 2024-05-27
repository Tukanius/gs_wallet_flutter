import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/history.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/utils/utils.dart';

class FiatHistoryCard extends StatefulWidget {
  final History data;
  const FiatHistoryCard({
    super.key,
    required this.data,
  });

  @override
  State<FiatHistoryCard> createState() => _FiatHistoryCardState();
}

class _FiatHistoryCardState extends State<FiatHistoryCard> {
  showDetail(context, data) {
    String createdDate = Utils.formatUTC8(data.createdAt!);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: MediaQuery.of(context).size.height * 0.40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
            color: white,
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: nfc,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Гүйлгээний дэлгэрэнгүй',
                style: TextStyle(
                  color: black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: greytext.withOpacity(0.2),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${data.description}:',
                    style: TextStyle(
                      color: greytext,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${data.totalAmount} GS',
                    style: TextStyle(
                      color: greentext,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Огноо:',
                    style: TextStyle(
                      color: greytext,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${createdDate}',
                    style: TextStyle(
                      color: black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String createdDate = Utils.formatUTC8(widget.data.createdAt!);

    return InkWell(
      onTap: () {
        showDetail(context, widget.data);
      },
      child: Container(
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
                      "${Utils().formatCurrency(widget.data.amount.toString())}₮",
                      style: TextStyle(
                        color: widget.data.type == "DEPOSIT"
                            ? greentext
                            : expenditure,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
