import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/components/score_status_card/bar_graph.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:health/health.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class ScoreStatusCard extends StatefulWidget {
  final bool? isActive;
  final String assetPath;

  const ScoreStatusCard({
    super.key,
    required this.assetPath,
    this.isActive,
  });

  @override
  State<ScoreStatusCard> createState() => _ScoreStatusCardState();
}

class _ScoreStatusCardState extends State<ScoreStatusCard> {
  List<double> stepsForLast7Days = [1, 1, 1, 1, 1, 1, 10];
  String? step;
  int stepIos = 0;
  int todaysSteps = 0;
  StreamSubscription<StepCount>? subscription;

  @override
  void initState() {
    super.initState();
    // _startListeningStep();
    // Platform.isIOS ? initIosHealth() : _requestPermission();
  }

  void _requestPermission() async {
    final PermissionStatus status =
        await Permission.activityRecognition.request();

    if (status == PermissionStatus.granted) {
      initAndroid();
    } else {
      print('Permission denied');
    }
  }

  void initAndroid() {
    subscription = Pedometer.stepCountStream.listen(
      (event) {
        print('===EVENT=====');
        print(event);
        print('===EVENT=====');
        setState(() {
          step = event.steps.toString();
        });
      },
    );
  }

  @override
  void dispose() {
    _startListeningStep();
    subscription?.cancel();
    super.dispose();
  }

  void _startListening() async {
    subscription = Pedometer.stepCountStream.listen(
      (event) {
        if (isToday(event.timeStamp)) {
          setState(() {
            todaysSteps = event.steps;
          });
        }
        print('===EVENT=====');
        print(isToday(event.timeStamp));
        print('===EVENT=====');
        setState(() {
          todaysSteps = event.steps.toInt();
        });
      },
    );
  }

  bool isToday(DateTime dateTime) {
    DateTime now = DateTime.now();
    return now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day;
  }

  initIosHealth() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      HealthFactory health = HealthFactory();
      var types = [HealthDataType.STEPS];
      var permissions = [HealthDataAccess.READ];

      bool requested =
          await health.requestAuthorization(types, permissions: permissions);
      if (requested) {
        final now = DateTime.now();
        final todayStart = DateTime(now.year, now.month, now.day);
        final todayEnd =
            todayStart.add(Duration(days: 1)).subtract(Duration(seconds: 1));
        try {
          var qwerty =
              await health.getHealthDataFromTypes(todayEnd, todayEnd, types);
          print(qwerty);
          int? stepsTd =
              await health.getTotalStepsInInterval(todayStart, todayEnd);
          setState(() {
            stepIos = stepsTd!;
          });
          print("Today's steps: $stepsTd");
        } catch (error) {
          print(error);
        }
      } else {
        print('=======Auth not granted======');
      }
    });
  }

  // initIos() async {
  //   DateTime startDate = DateTime.now().toUtc();
  //   DateTime endDate = DateTime.now().toUtc();

  //   try {
  //     List<HealthDataPoint> healthData =
  //         await HealthDataPoint.getHealthDataFromType(
  //       startDate: startDate,
  //       endDate: endDate,
  //       dataType: HealthDataType.STEPS,
  //     );

  //     int totalSteps = 0;
  //     for (var dataPoint in healthData) {
  //       totalSteps += dataPoint.value.round();
  //     }

  //     setState(() {
  //       _steps = totalSteps;
  //     });
  //   } catch (e) {
  //     print("Failed to fetch steps: $e");
  //   }
  // }

  // This Code for swift ?
  // int _stepCount = 0;

  // static const platform = const MethodChannel('samples.health.io/stepcount');

  // Future<void> initIos() async {
  //   int stepCount;
  //   try {
  //     final int result = await platform.invokeMethod('getStepCount');
  //     stepCount = result;
  //   } on PlatformException catch (e) {
  //     print("Failed to get step count: '${e.message}'.");
  //     stepCount = 0;
  //   }

  //   setState(() {
  //     _stepCount = stepCount;
  //   });
  // }
  int stepforIOS = 0;

  static const platform = const MethodChannel('step_counter_channel');

  void _startListeningStep() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      try {
        final int result = await platform.invokeMethod('startListening');
        print('======STEPFORIOS=====');
        print(result);
        if (mounted) {
          setState(() {
            stepforIOS += result;
          });
        }
        print('======STEPFORIOS=====');
      } on PlatformException catch (e) {
        print("Failed to start listening: '${e.message}'.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      height: 250,
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
                        SvgPicture.asset('assets/svg/active_dot.svg'),
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
                    Platform.isIOS ? '${stepIos}' : '${step}',
                    style: TextStyle(
                      color: white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                Platform.isIOS ? '$stepforIOS' : '0',
                style: TextStyle(
                  color: white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: MyBarGraph(
              weeklySum: stepsForLast7Days,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '1',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '2',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '3',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '4',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '5',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '6',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '7',
                style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
