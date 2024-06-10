import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/order.dart';
import 'package:green_score/utils/utils.dart';
import 'package:green_score/widget/ui/color.dart';

class OrderHistoryCard extends StatefulWidget {
  final Order data;

  const OrderHistoryCard({
    super.key,
    required this.data,
  });

  @override
  State<OrderHistoryCard> createState() => _TokenHistoryCardState();
}

class _TokenHistoryCardState extends State<OrderHistoryCard> {
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
                'Түүхийн дэлгэрэнгүй',
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
                    'Төлсөн дүн:',
                    style: TextStyle(
                      color: greytext,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${Utils().formatCurrency(widget.data.totalAmount.toString())}₮',
                    style: TextStyle(
                      color: black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ашигласан оноо: ',
                    style: TextStyle(
                      color: greytext,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${widget.data.saleTokenAmount} GS',
                    style: TextStyle(
                      color: greentext,
                      fontSize: 15,
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
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${createdDate}',
                    style: TextStyle(
                      color: black,
                      fontSize: 15,
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
                SvgPicture.asset('assets/svg/bag.svg'),
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
                      'Төлсөн дүн: ${Utils().formatCurrency(widget.data.totalAmount.toString())}₮',
                      style: TextStyle(
                        color: white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Ашигласан оноо: ',
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.data.saleTokenAmount} GS',
                          style: TextStyle(
                            color: greentext,
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
          ],
        ),
      ),
    );
  }
}
