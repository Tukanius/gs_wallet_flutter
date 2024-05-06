import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:green_score/api/wallet_api.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/qr_read.dart';
import 'package:green_score/src/main_page.dart';
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
        isLoading = false;
      });
    } catch (err) {
      print('+=======QRID=========');
      print(qr.id);
      print('+=======QRID=========');
      setState(() {
        isLoading = false;
      });
      print("not found qr token !!!");
    }
  }

  onConfirm(String id) async {
    print('========ID=====');
    print(id);
    print('========ID=====');
    try {
      setState(() {
        isLoading = true;
      });
      qr = await WalletApi().confirmQr(qr.id!);
      Navigator.of(context).pushNamed(MainPage.routeName);
      print('========ID=====');
      print(qr.id);
      print('========ID=====');
    } catch (e) {
      print(e.toString());
    }
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
            : Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${qr.totalAmount}',
                      style: TextStyle(color: white),
                    ),
                    Text(
                      'Таны урамшуулал',
                      style: TextStyle(color: white),
                    ),
                    CustomButton(
                      onClick: () {
                        onConfirm(qr.id!);
                      },
                      buttonColor: greentext,
                      height: 40,
                      isLoading: false,
                      labelText: "Зөвшөөрөх",
                      textColor: white,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
