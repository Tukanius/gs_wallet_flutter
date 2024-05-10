import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';

void trade(BuildContext context, String id) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
          color: white,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: nfc,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Center(
                      child: Text(
                        id == "1" ? 'Зарах' : 'Авах',
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset('assets/svg/close.svg'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                                fontSize: 16,
                                color: black,
                              ),
                            ),
                            Text(
                              id == "1" ? '0.39' : '0.4',
                              style: TextStyle(
                                fontSize: 28,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        id == "1"
                            ? Row(
                                children: [
                                  SvgPicture.asset('assets/svg/gs_sell.svg'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '2,540.00 GS',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/wallet_black.svg',
                                    height: 20,
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '₮50,000.00',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                FormTextField(
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Үнэ',
                        style: TextStyle(
                          color: greytext,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MNT',
                        style: TextStyle(
                          color: greytext,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.end,
                  hintText: "0.0",
                  colortext: black,
                  color: black.withOpacity(0.04),
                  name: "price",
                ),
                SizedBox(height: 12),
                FormTextField(
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/gs.svg'),
                    ],
                  ),
                  textAlign: TextAlign.end,
                  hintText: id == "1" ? "Зарах дүн" : "Авах дүн",
                  colortext: black,
                  color: black.withOpacity(0.04),
                  name: "sell price",
                ),
                SizedBox(height: 12),
                FormTextField(
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      id == "1"
                          ? SvgPicture.asset('assets/svg/gs.svg')
                          : Row(
                              children: [
                                SizedBox(
                                  width: 14,
                                ),
                                SvgPicture.asset('assets/svg/sell_mnt.svg')
                              ],
                            ),
                    ],
                  ),
                  readOnly: true,
                  hintText: "0",
                  hintTextColor: black,
                  textAlign: TextAlign.end,
                  colortext: black,
                  color: black.withOpacity(0.04),
                  name: "search",
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: id == "1" ? red : greentext,
                    ),
                    child: Center(
                      child: Text(
                        id == "1" ? "Зарах" : "Авах",
                        style: TextStyle(
                          color: white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
