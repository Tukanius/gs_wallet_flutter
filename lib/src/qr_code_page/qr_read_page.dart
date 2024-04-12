import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/src/qr_code_page/qr_transfer.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrReadPage extends StatefulWidget {
  static const routeName = "QrReadPage";
  const QrReadPage({Key? key}) : super(key: key);

  @override
  State<QrReadPage> createState() => _QrReadPageState();
}

class _QrReadPageState extends State<QrReadPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: buildQrView(context),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: transparent,
              child: AppBar(
                backgroundColor: transparent,
                automaticallyImplyLeading: false,
                centerTitle: true,
                leading: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    CustomBackButton(
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                title: Text(
                  'QR унших',
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  bool isNavigated = false;
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!isNavigated) {
        setState(() {
          result = scanData;
        });
        if (result != null) {
          isNavigated = true;
          Navigator.of(context)
              .pushNamed(
            QrTransferPage.routeName,
            arguments: QrTransferPageArguments(data: result!),
          )
              .then((_) {
            isNavigated = false;
          });
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
