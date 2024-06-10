import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_score/api/score_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/components/score_status_card/school_status_card.dart';
import 'package:green_score/models/accumlation.dart';
import 'package:green_score/models/nfc_data.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_manager/nfc_manager.dart';

class SchoolCardPageArguments {
  String title;
  String assetPath;

  SchoolCardPageArguments({
    required this.title,
    required this.assetPath,
  });
}

class SchoolCardPage extends StatefulWidget {
  final String title;
  final String assetPath;

  static const routeName = "SchoolCardPage";
  const SchoolCardPage({
    super.key,
    required this.title,
    required this.assetPath,
  });

  @override
  State<SchoolCardPage> createState() => _SchoolCardPageState();
}

class _SchoolCardPageState extends State<SchoolCardPage> with AfterLayoutMixin {
  bool isConnected = false;
  bool isLoading = false;
  Accumlation schoolCard = Accumlation();
  NfcData nfcData = NfcData();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      schoolCard.type = "COMMUNITY";
      schoolCard.code = "SCHOOL";
      schoolCard = await ScoreApi().getStep(schoolCard);
      print('=======+TEST=======');
      print(schoolCard);
      print('=======+TEST=======');
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showNFCBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        startNFCReading();
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: nfc,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(),
                      Text(
                        'Карт холбох',
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.of(context).pop();
                      //   },
                      //   child: SvgPicture.asset('assets/svg/close.svg'),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Lottie.asset('assets/lottie/nfc.json'),
                  // Image.asset(
                  //   'assets/images/nfc.jpg',
                  //   fit: BoxFit.cover,
                  // ),
                  SizedBox(height: 20),
                  Text(
                    'Сургуулийн картаа утасныхаа NFC уншигчид хүргэж картыхаа мэдээллийг оруулна уу.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  comingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bg,
          content: Text(
            'Тун удахгүй!',
            style: TextStyle(
              color: white,
              fontSize: 18,
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> startNFCReading() async {
    print('======READY to READ======');
    try {
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          try {
            print('Tag discovered: ${tag.data}');

            if (tag.data.containsKey('isodep')) {
              Map<String, dynamic> jsonMap = tag.data;
              List<int> identifier =
                  List<int>.from(jsonMap['isodep']['identifier']);

              String cardIdHex = identifier
                  .map((e) => e.toRadixString(16).padLeft(2, '0'))
                  .join();
              print('Card ID Hex: $cardIdHex');

              nfcData.nfcCode = cardIdHex;

              var res = await ScoreApi().nfcConnect(nfcData);
              print('Response: $res');

              await NfcManager.instance.stopSession();

              Navigator.of(context).pop();
            } else {
              print('isodep not found in tag data');
            }
          } catch (e) {
            print('Error processing NFC tag: $e');
          }
        },
      );
    } catch (e) {
      print('Error starting NFC session: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
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
                '${widget.title}',
                style: TextStyle(
                  color: white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SchoolCard(
                  isConnected: false,
                  assetPath: "${widget.assetPath}",
                ),
                SizedBox(
                  height: 30,
                ),
                isConnected == false
                    ? CustomButton(
                        circular: 100,
                        labelText: 'Карт холбох',
                        height: 40,
                        buttonColor: buttonbg,
                        isLoading: false,
                        onClick: () {
                          _showNFCBottomSheet(context);
                        },
                        textColor: white,
                      )
                    : CustomButton(
                        circular: 100,
                        labelText: 'Урамшуулал авах',
                        height: 40,
                        buttonColor: greentext,
                        isLoading: false,
                        onClick: () {
                          comingSoon(context);
                        },
                        textColor: white,
                      ),
                SizedBox(
                  height: 30,
                ),
                isConnected == false
                    ? SizedBox()
                    : Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: buttonbg,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/svg/calendar.svg'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '2024.04.24',
                                  style: TextStyle(
                                    color: greytext,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '-',
                                  style: TextStyle(
                                    color: greytext,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset('assets/svg/calendar.svg'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '2024.04.24',
                                  style: TextStyle(
                                    color: greytext,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: buttonbg,
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Text(
                                        'Өчигдөр',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 16,
                                  width: 1,
                                  color: greytext,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Text(
                                        '7 хоног',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 16,
                                  width: 1,
                                  color: greytext,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Text(
                                        'Сар',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                Text(
                  'Түүх',
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      SvgPicture.asset(
                        'assets/svg/notfound.svg',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${widget.title}',
                        style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Түүх олдсонгүй',
                        style: TextStyle(
                          color: greytext,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
