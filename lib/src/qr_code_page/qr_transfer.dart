import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:green_score/widget/ui/qwerty.dart';
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
  @override
  afterFirstLayout(BuildContext context) {
    print('===DATA=====');
    print(widget.data.code);
    print('===DATA=====');
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '${widget.data.code}',
              style: TextStyle(color: white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26), color: greentext),
              child: Center(
                child: Text(
                  'Transfer',
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
