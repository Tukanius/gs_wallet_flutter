import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/models/account.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:provider/provider.dart';
import 'package:green_score/utils/utils.dart';

class AccountCard extends StatefulWidget {
  final Account data;
  final bool isAll;
  const AccountCard({super.key, required this.data, required this.isAll});

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  bool isView = false;

  @override
  Widget build(BuildContext context) {
    isView = Provider.of<UserProvider>(context, listen: true).isView;
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
                  ? GestureDetector(
                      child: isView == false
                          ? Icon(
                              Icons.visibility,
                              color: white,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: white,
                            ),
                      // child: isView == false
                      //     ? SvgPicture.asset('assets/svg/eye.svg')
                      //     : SvgPicture.asset('assets/svg/eye_on.svg'),

                      onTap: () async {
                        print(isView);
                        await Provider.of<UserProvider>(context, listen: false)
                            .setView(!isView);
                      },
                    )
                  : SizedBox(),
            ],
          ),
          widget.data.type == "TOKEN"
              ? FormTextField(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: '${widget.data.txHash}'),
                      ).then(
                        (value) {
                          return ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: white,
                              content: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Амжилттай хуулсан',
                                    style: TextStyle(
                                      color: black,
                                    ),
                                  ),
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
                          // ignore: deprecated_member_use
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
                          "${Utils().formatCurrency(widget.data.balanceAmount.toString())}",
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
                      isView == false
                          ? "${Utils().formatCurrency(widget.data.balanceAmount.toString())}₮"
                          : "*******",
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
