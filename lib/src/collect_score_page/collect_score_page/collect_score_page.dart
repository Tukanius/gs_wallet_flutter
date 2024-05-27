import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/score_api.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/models/accumlation.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:lottie/lottie.dart';

class CollectScorePageArguments {
  String id;

  CollectScorePageArguments({
    required this.id,
  });
}

class CollectScorePage extends StatefulWidget {
  final String id;
  static const routeName = "CollectScorePage";
  const CollectScorePage({
    super.key,
    required this.id,
  });

  @override
  State<CollectScorePage> createState() => _CollectScorePageState();
}

class _CollectScorePageState extends State<CollectScorePage>
    with AfterLayoutMixin {
  bool isLoading = true;
  bool isLoadingButton = false;

  Accumlation walk = Accumlation();
  Deposit getData = Deposit();
  @override
  afterFirstLayout(BuildContext context) async {
    await _getWalk();
  }

  _getWalk() async {
    try {
      walk.type = "WALK";
      walk.code = "WALK_01";
      walk = await ScoreApi().getStep(walk);
      getData = await ScoreApi().redeemCalculate(widget.id);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  onSubmit(ctx) async {
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Та урамшуулал авахдаа итгэлтэй байна уу.',
                      style: TextStyle(
                        color: dark,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonColor: white,
                            labelText: 'Буцах',
                            isLoading: false,
                            height: 40,
                            onClick: () {
                              Navigator.of(context).pop();
                            },
                            textColor: black,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CustomButton(
                            buttonColor: greentext,
                            labelText: 'Зөвшөөрөх',
                            height: 40,
                            isLoading: isLoading,
                            onClick: () {
                              onRedeem();
                              Navigator.of(context).pop();
                            },
                            textColor: white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  onRedeem() async {
    if (walk.isRedeem == true) {
      try {
        setState(() {
          isLoadingButton = true;
        });
        var res = await ScoreApi().onRedeem(widget.id);
        print(res);
        showSuccess(context);
        setState(() {
          isLoadingButton = false;
        });
        Navigator.of(context).pushNamed(MainPage.routeName);
      } catch (e) {
        setState(() {
          isLoadingButton = false;
        });
        print(e.toString());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: white,
          content: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Урамшуулал авах хамгийн бага утга 10',
                style: TextStyle(
                  color: black,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  showSuccess(ctx) async {
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
                      'Урамшуулал нэмэгдлээ.',
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
              leading: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CustomBackButton(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              centerTitle: true,
              title: Text(
                'Урамшуулал авах',
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
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            // margin: EdgeInsets.symmetric(
                            //   // vertical: 32,
                            //   horizontal: 20,
                            // ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            height: 175,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: buttonbg,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  'Цуглуулсан',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Text(
                                  'Авах пойнт',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${getData.amount}GS',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: -5,
                            top: -5,
                            child: SvgPicture.asset(
                              'assets/svg/leaf2.svg',
                            ),
                          ),
                          Positioned(
                            right: -2,
                            top: -2,
                            child: SvgPicture.asset(
                              'assets/svg/leaf1.svg',
                            ),
                          ),
                          Positioned(
                            bottom: -2,
                            left: -2,
                            child: SvgPicture.asset(
                              'assets/svg/leaf3.svg',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Та нийт ',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${walk.balanceAmount}',
                                    style: TextStyle(
                                      color: greentext,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' алхсан байна.',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Та алхам 10 тутамдаа 200GS оноо цуглуулах боломжтой.',
                              style: TextStyle(
                                color: white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Green Score Nature -ийг сонгосонд баярлалаа.',
                              style: TextStyle(
                                color: white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CustomButton(
                          circular: 100,
                          buttonColor: greentext,
                          height: 40,
                          isLoading: isLoadingButton,
                          labelText: 'Баталгаажуулах',
                          onClick: () {
                            onRedeem();
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
                          labelText: 'Буцах',
                          onClick: () {
                            Navigator.of(context).pop();
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
              ),
      ),
    );
  }
}
