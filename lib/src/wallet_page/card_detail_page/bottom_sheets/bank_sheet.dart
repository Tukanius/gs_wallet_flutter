import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/form_textfield.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:lottie/lottie.dart';

showSuccess(context) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 75),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Амжилттай',
                    style: TextStyle(
                        color: dark, fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Данс амжилттай цэнэглэгдлээ.',
                    textAlign: TextAlign.center,
                  ),
                  ButtonBar(
                    buttonMinWidth: 100,
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text(
                          "Буцах",
                          style: TextStyle(color: dark),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Lottie.asset('assets/success.json', height: 150, repeat: false),
          ],
        ),
      );
    },
  );
}

bank(BuildContext context, Deposit data) {
  bool isLoading = false;
  Deposit deposit = Deposit();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) {
        onSubmit() async {
          try {
            setState(() {
              isLoading = true;
            });
            deposit = await WalletApi().depositConfirm(data.id!);
            Timer(Duration(seconds: 3), () {
              setState(() {
                isLoading = false;
              });
              Navigator.of(context).pushNamed(MainPage.routeName);
              showSuccess(context);
            });

            print(deposit);
          } catch (e) {
            print(e.toString());
            setState(() {
              isLoading = false;
            });
          }
        }

        ;
        onCheck() {
          setState(() {
            isLoading = true;
          });
          try {} catch (e) {
            print(e.toString());
          }
          setState(() {
            isLoading = false;
          });
        }

        ;
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
                          'Данс',
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
                  Text(
                    '   Дансны дугаар:',
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FormTextField(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: '900 004 7728'))
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
                          SvgPicture.asset('assets/svg/copy.svg'),
                        ],
                      ),
                    ),
                    hintText: "5050232303",
                    colortext: black,
                    color: black.withOpacity(0.04),
                    name: "search",
                    hintTextColor: black,
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '   Дансны нэр:',
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FormTextField(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print("object");
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svg/copy.svg'),
                        ],
                      ),
                    ),
                    hintText: "Good Score",
                    colortext: black,
                    color: black.withOpacity(0.04),
                    hintTextColor: black,
                    name: "search",
                    readOnly: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '   Гүйлгээний утга:',
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FormTextField(
                    readOnly: true,
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/copy.svg'),
                      ],
                    ),
                    hintText: "Цэнэглэлт - 99555555",
                    hintTextColor: black,
                    colortext: black,
                    color: black.withOpacity(0.04),
                    name: "search",
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  data.paymentStatus == "NEW"
                      ? CustomButton(
                          height: 40,
                          buttonColor: greentext,
                          circular: 100,
                          isLoading: isLoading,
                          labelText: 'Төлбөр төлөх',
                          onClick: () {
                            onSubmit();
                          },
                          textColor: white,
                        )
                      : CustomButton(
                          height: 40,
                          buttonColor: greentext,
                          circular: 100,
                          isLoading: isLoading,
                          labelText: 'Төлбөр шалгах',
                          onClick: () {
                            onCheck();
                          },
                          textColor: white,
                        )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
