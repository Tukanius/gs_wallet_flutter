import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/models/qr_read.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/src/qr_code_page/confirm_qr_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
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
  QrRead qr = QrRead();
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

  onConfirm() async {
    try {
      setState(() {
        isLoading = true;
      });
      deposit = await WalletApi().confirmQr(qr.id!);
      setState(() {
        isLoading = false;
      });
      qr.paymentMethod == "CASH"
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

  onAutoConfirm() async {
    try {
      setState(() {
        isLoading = true;
      });
      deposit = await WalletApi().confirmQr(qr.id!);
      print('=======DEPO ON=====');
      print(deposit.id);
      print('=======DEPO ON=====');

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

  pushMain() {
    Navigator.of(context).pushNamed(MainPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackgroundShapes(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Таны оруулсан QR буруу байна.',
                          style: TextStyle(color: white),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          onClick: () {
                            Navigator.of(context).pushNamed(MainPage.routeName);
                          },
                          buttonColor: greentext,
                          height: 40,
                          isLoading: false,
                          labelText: "Ок",
                          textColor: white,
                        ),
                      ],
                    ),
                  )
                : qr.id != null
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            qr.paymentMethod == "CASH"
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Баталгаажуулах',
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Нийт төлөх дүн: ${qr.totalAmount}',
                                        style: TextStyle(color: white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Төлбөрийн хэрэгсэл: ${qr.paymentMethod}',
                                        style: TextStyle(color: white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      qr.isSale == true
                                          ? Text(
                                              'Ашиглагдах GS бонус: ${qr.saleTokenAmount}',
                                              style: TextStyle(color: white),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      CustomButton(
                                        onClick: () {
                                          onConfirm();
                                        },
                                        buttonColor: greentext,
                                        height: 40,
                                        isLoading: isLoading,
                                        labelText: "Баталгаажуулах",
                                        textColor: white,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CustomButton(
                                        onClick: () {
                                          Navigator.of(context)
                                              .pushNamed(MainPage.routeName);
                                        },
                                        buttonColor: buttonbg,
                                        height: 40,
                                        isLoading: false,
                                        labelText: "Болих",
                                        textColor: white,
                                      ),
                                    ],
                                  )
                                : qr.isSale == true
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Ашиглагдах GS бонус: ${qr.saleTokenAmount}',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          CustomButton(
                                            onClick: () {
                                              onConfirm();
                                            },
                                            buttonColor: greentext,
                                            height: 40,
                                            isLoading: isLoading,
                                            labelText: "Оноо ашиглах",
                                            textColor: white,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomButton(
                                            onClick: () {
                                              Navigator.of(context).pushNamed(
                                                  MainPage.routeName);
                                            },
                                            buttonColor: buttonbg,
                                            height: 40,
                                            isLoading: false,
                                            labelText: "Болих",
                                            textColor: white,
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                          ],
                        ),
                      )
                    : SizedBox(),
      ),
    );
  }
}
