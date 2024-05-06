import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/account.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';

class CustomCard extends StatefulWidget {
  final Account data;
  final bool isAll;
  const CustomCard({super.key, required this.data, required this.isAll});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: buttonbg,
      ),
      height: 220,
      width: widget.isAll == false
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  widget.data.type == "TOKEN"
                      ? Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/gsc.svg",
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Green',
                              style: TextStyle(
                                  color: greentext,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Score',
                              style: TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/mnt.svg",
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Үндсэн данс',
                              style: TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
              widget.data.type != "TOKEN"
                  ? SvgPicture.asset('assets/svg/eye.svg')
                  : SizedBox(),
            ],
          ),
          widget.data.type == "TOKEN"
              ? FormTextField(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                              ClipboardData(text: '${widget.data.txHash}'))
                          .then(
                        (value) {
                          return ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: greytext,
                              content: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Амжилттай хуулсан'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/copy.svg',
                          color: white,
                        ),
                      ],
                    ),
                  ),
                  initialValue: widget.data.txHash != null
                      ? '${widget.data.txHash!.substring(0, 5)}${'*' * (widget.data.txHash!.length - 8)}${widget.data.txHash!.substring(widget.data.txHash!.length - 3)}'
                      : "-  ",
                  colortext: white,
                  hintText: '-',
                  color: black.withOpacity(0.04),
                  name: "search",
                  hintTextColor: white,
                  readOnly: true,
                )
              : SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Дансны үлдэгдэл',
                style: TextStyle(
                  color: white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              widget.data.type == "TOKEN"
                  ? Row(
                      children: [
                        Text(
                          '${widget.data.balanceAmount}',
                          style: TextStyle(
                            color: greentext,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(
                          'assets/svg/leaf_green.svg',
                        ),
                      ],
                    )
                  : Text(
                      '${widget.data.balanceAmount} ₮',
                      style: TextStyle(
                        color: white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
