import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/models/order.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/src/qr_code_page/confirm_payment.dart';
import 'package:green_score/utils/utils.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrTransferPageArguments {
  Barcode data;

  QrTransferPageArguments({
    required this.data,
  });
}

class QrTransferPage extends StatefulWidget {
  static const routeName = "QrTransferPage";
  final Barcode data;
  const QrTransferPage({super.key, required this.data});

  @override
  State<QrTransferPage> createState() => _QrTransferState();
}

class _QrTransferState extends State<QrTransferPage> with AfterLayoutMixin {
  bool isLoading = true;
  String id = '';
  String iv = '';
  Order qr = Order();
  Deposit deposit = Deposit();
  bool success = false;
  @override
  afterFirstLayout(BuildContext context) async {
    List<String> parts = widget.data.code!.split('?');
    if (parts.length == 2) {
      id = parts[0];
      iv = parts[1];
    } else {
      print('Wrong qr !!!');
    }

    try {
      qr.iv = iv;
      qr = await WalletApi().readQr(id, qr);
      setState(() {
        success = true;
        isLoading = false;
      });
      if (qr.isSale == false && qr.paymentMethod == "CASH") {
        await cashConfirm();
      }
      if (qr.isSale == false && qr.paymentMethod != "CASH") {
        await onAutoConfirm();
      }
    } catch (err) {
      setState(() {
        success = false;
        isLoading = false;
      });
      print("not found qr token !!!");
    }
  }

  cashConfirm() async {
    try {
      setState(() {
        isLoading = true;
      });
      Timer(Duration(seconds: 3), () {
        setState(() {
          isLoading = true;
        });
        onConfirm();
        Navigator.of(context).pushNamed(MainPage.routeName);
        showSuccess(context);
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  onConfirm() async {
    try {
      setState(() {
        isLoading = true;
      });
      deposit = await WalletApi().confirmQr(qr.id!);
      setState(() {
        isLoading = false;
      });
      if (qr.paymentMethod == "CASH") {
        Navigator.of(context).pushNamed(MainPage.routeName);
        showSuccess(context);
      } else {
        Navigator.of(context).pushNamed(
          ConfirmQrCodePage.routeName,
          arguments: ConfirmQrCodePageArguments(data: deposit),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  onAutoConfirm() async {
    try {
      setState(() {
        isLoading = true;
      });
      deposit = await WalletApi().confirmQr(qr.id!);

      setState(() {
        isLoading = false;
      });
      deposit.id == null
          ? Navigator.of(context).pushNamed(MainPage.routeName)
          : Navigator.of(context).pushNamed(
              ConfirmQrCodePage.routeName,
              arguments: ConfirmQrCodePageArguments(data: deposit),
            );
      ;
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

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
                          color: dark,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Худалдан авалт амжилттай.',
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackgroundShapes(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
            return <Widget>[
              SliverAppBar(
                toolbarHeight: 60,
                automaticallyImplyLeading: false,
                pinned: false,
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: transparent,
                leading: CustomBackButton(
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                ),
                centerTitle: true,
                title: Text(
                  'Баталгаажуулах',
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ];
          },
          body: isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: greentext,
                  ),
                )
              : success == false
                  ? Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Lottie.asset(
                            'assets/error.json',
                            repeat: false,
                            height: 150,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Таны оруулсан QR буруу байна.',
                            style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            onClick: () {
                              Navigator.of(context)
                                  .pushNamed(MainPage.routeName);
                            },
                            buttonColor: buttonbg,
                            height: 40,
                            circular: 100,
                            isLoading: false,
                            labelText: "Буцах",
                            textColor: white,
                          ),
                        ],
                      ),
                    )
                  : qr.id != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(20),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: buttonbg,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Нийт төлөх дүн:',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            '${Utils().formatCurrency(qr.totalAmount.toString())}₮',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Төлбөрийн хэрэгсэл:',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            '${qr.paymentMethod}',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      qr.isSale == true
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Ашиглагдах GS бонус:',
                                                  style: TextStyle(
                                                    color: white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  '${qr.saleTokenAmount}GS',
                                                  style: TextStyle(
                                                    color: greentext,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  CustomButton(
                                    circular: 100,
                                    buttonColor: greentext,
                                    height: 40,
                                    isLoading: isLoading,
                                    labelText: 'Баталгаажуулах',
                                    onClick: () {
                                      onConfirm();
                                    },
                                    textColor: white,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomButton(
                                    circular: 100,
                                    buttonColor: buttonbg,
                                    height: 40,
                                    isLoading: false,
                                    labelText: 'Болих',
                                    onClick: () {
                                      Navigator.of(context)
                                          .pushNamed(MainPage.routeName);
                                    },
                                    textColor: white,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
        ),
      ),
    );
  }
}
