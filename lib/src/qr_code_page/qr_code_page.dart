import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/bonus_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/src/qr_code_page/qr_read_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatefulWidget {
  static const routeName = "QrCodePage";
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> with AfterLayoutMixin {
  @override
  afterFirstLayout(BuildContext context) async {
    var qr = await BonusApi().gerQr();
    print('=====QR=======');
    print(qr);
    print('=====QR=======');
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
      body: Scaffold(
        backgroundColor: transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: transparent,
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
            'QR код',
            style: TextStyle(
              color: white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: buttonbg,
                ),
                child: Center(
                  child: QrImageView(
                    data:
                        'image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIQAAACECAYAAABRRIOnAAAAAklEQVR4AewaftIAAAOWSURBVO3BQW7dWAIEwayHf/8r52jRi1oRIEhJtqci4hdm/',
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: white,
                    ),
                    eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(QrReadPage.routeName);
                        },
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: buttonbg,
                          ),
                          child: Center(
                              child:
                                  SvgPicture.asset('assets/svg/qr_camera.svg')),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Камера',
                        style: TextStyle(
                          color: white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: buttonbg,
                        ),
                        child: Center(
                            child: SvgPicture.asset('assets/svg/download.svg')),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Татах',
                        style: TextStyle(
                          color: white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
