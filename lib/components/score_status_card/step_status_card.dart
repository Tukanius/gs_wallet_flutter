import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/api/score_api.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/components/score_status_card/bar_data/bar_graph.dart';
import 'package:green_score/models/accumlation.dart';
import 'package:green_score/src/collect_score_page/collect_score_page/collect_score_page.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:lottie/lottie.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepStatusCard extends StatefulWidget {
  final bool? isActive;
  final String assetPath;
  const StepStatusCard({
    super.key,
    required this.assetPath,
    this.isActive,
  });

  @override
  State<StepStatusCard> createState() => _StepStatusCardState();
}

class _StepStatusCardState extends State<StepStatusCard> with AfterLayoutMixin {
  // @override
  // afterFirstLayout(BuildContext context) async {
  //   try {
  //     walk = await Provider.of<ToolsProvider>(context, listen: false).getStep();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  List<double> stepsForLast7Days = List<double>.filled(7, 0.0);
  String? step;
  bool isLoading = true;
  bool isButtonLoad = false;
  Accumlation walk = Accumlation();

  num stepped = 0;
  late StreamSubscription<StepCount> subscription;
  bool show = false;
  @override
  afterFirstLayout(BuildContext context) async {
    await requestPermission();
    await getWalk();
  }

  getWalk() async {
    try {
      setState(() {
        isButtonLoad = true;
      });
      walk.type = "WALK";
      walk.code = "WALK_01";
      walk = await ScoreApi().getStep(walk);
      print('====TEST=====');
      print(walk.toJson());
      print('====TEST=====');
      walk.lastWeekTotal != null
          ? stepsForLast7Days = walk.lastWeekTotal!
              .map((data) => data.totalAmount!.toDouble())
              .toList()
          : List<double>.filled(7, 0.0);
      // List<double> step7day = [];

      // if (walk.lastWeekTotal != null) {
      //   step7day = walk.lastWeekTotal!
      //       .map((data) => data.totalAmount as double)
      //       .toList();
      //   print('======testgemini====');
      //   print(step7day);
      //   print('======testgemini====');
      // } else {
      //   print("Last week's total steps data is unavailable.");
      // }
      // walk.lastWeekTotal != null
      //     ? walk.lastWeekTotal!
      //         .map((data) =>
      //             stepsForLast7Days = data.totalAmount as List<double>)
      //         .toList()
      //     : SizedBox();
      // print('======lastweek====');
      // print(walk.lastWeekTotal);
      // print(stepsForLast7Days);
      // print('======lastweek====');
      if (walk.balanceAmount == 0 || walk.balanceAmount == null) {
        setState(() {
          stepped = 0;
        });
      } else {
        setState(() {
          stepped = walk.balanceAmount!;
        });
      }
      setState(() {
        isButtonLoad = false;

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isButtonLoad = false;

        isLoading = false;
      });
      print(e.toString());
    }
  }

  requestPermission() async {
    final PermissionStatus status =
        await Permission.activityRecognition.request();
    print('===========STEP PERMISSION========');
    print(status);
    print('===========STEP PERMISSION========');
    if (status == PermissionStatus.granted) {
      calculateStep();
    } else {
      calculateStep();
    }
  }

  void calculateStep() async {
    Accumlation sendWalk = Accumlation();

    // await getWalk();
    int? previousStepCount;
    subscription = Pedometer.stepCountStream.listen(
      (event) {
        int currentStepCount = event.steps;
        int stepsSinceLastEvent = previousStepCount != null
            ? currentStepCount - previousStepCount!
            : 0;
        previousStepCount = currentStepCount;
        if (mounted) {
          setState(() {
            sendWalk.amount = stepsSinceLastEvent.toString();
            stepped += stepsSinceLastEvent;
            if (previousStepCount != null && stepsSinceLastEvent != 0) {
              ScoreApi().sendStep(sendWalk);
            }
            step = stepsSinceLastEvent.toString();
          });
        }
      },
    );
  }

  showFailed(ctx) async {
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
                      'Амжилтгүй',
                      style: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Урамшуулал татах боломжгүй.',
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
              Lottie.asset('assets/error.json', height: 150, repeat: false),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: buttonbg,
      ),
      child: Column(
        children: [
          Row(
            children: [
              widget.isActive == true
                  ? Row(
                      children: [
                        Lottie.asset(
                          'assets/lottie/live.json',
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  : SizedBox(),
              SvgPicture.asset(
                '${widget.assetPath}',
                height: 36,
                width: 36,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Алхалт',
                    style: TextStyle(
                      color: white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    isLoading == false
                        ? walk.balanceAmount != null && walk.balanceAmount != 0
                            ? '${stepped}'
                            : '0'
                        : "-",
                    // '${walk.balanceAmount}',
                    style: TextStyle(
                      color: white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          isButtonLoad == true
              ? SizedBox(
                  height: 120,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: greentext,
                    ),
                  ),
                )
              : SizedBox(
                  height: 120,
                  child: MyBarGraph(
                    data: walk,
                    weeklySum: stepsForLast7Days,
                  ),
                ),
          SizedBox(
            height: 10,
          ),
          show == true
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    border: Border.all(color: red),
                  ),
                  child: Center(
                    child: Text(
                      'Урамшуулал авах боломжгүй байна.',
                      style: TextStyle(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            circular: 100,
            labelText: 'Урамшуулал татах',
            height: 40,
            buttonColor: greentext,
            isLoading: isLoading,
            onClick: () async {
              Accumlation walk = Accumlation();
              // await getWalk();
              walk.type = "WALK";
              walk.code = "WALK_01";
              walk = await ScoreApi().getStep(walk);
              walk.isRedeem == true
                  ? Navigator.of(context).pushNamed(
                      CollectScorePage.routeName,
                      arguments: CollectScorePageArguments(id: walk.id!),
                    )
                  : setState(() {
                      show = true;
                    });
            },
            textColor: white,
          ),
        ],
      ),
    );
  }
}
