import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/widget/ui/color.dart';

class CustomCard extends StatefulWidget {
  final String id;
  final bool isAll;
  const CustomCard({super.key, required this.id, required this.isAll});

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
      child: widget.id == "3"
          ? Center(
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: buttonbg,
                ),
                child: Icon(
                  Icons.add,
                  color: white,
                  size: 35,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        widget.id == "1"
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
                    widget.id != "1"
                        ? SvgPicture.asset('assets/svg/eye.svg')
                        : SizedBox(),
                  ],
                ),
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
                    widget.id == "1"
                        ? Row(
                            children: [
                              Text(
                                '560.00',
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
                            '25,000.00 ₮',
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
