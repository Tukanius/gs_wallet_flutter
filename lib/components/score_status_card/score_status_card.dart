import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_score/components/custom_button/custom_button.dart';
import 'package:green_score/components/score_status_card/bar_graph.dart';
import 'package:green_score/models/accumlation.dart';
import 'package:green_score/models/location_info.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_score/api/score_api.dart';

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

class _ScoreStatusCardState extends State<ScoreStatusCard>
    with AfterLayoutMixin {
  List<double> stepsForLast7Days = [1, 2, 3, 4, 5, 6, 7];
  String? step;
  bool isLoading = true;
  bool isButtonLoad = false;
  Accumlation data = Accumlation();
  Accumlation walk = Accumlation();
  num stepped = 0;
  late StreamSubscription<StepCount> subscription;
  late LocationSettings locationSettings;
  LocationInfo info = LocationInfo();
  @override
  void initState() {
    super.initState();
    _requestLocation();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  _requestLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    final PermissionStatus status = await Permission.locationAlways.request();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        await _getLocation();
      }
    }
    if (status == PermissionStatus.granted) {
      await _getLocation();
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      await _getLocation();
      print('Permission permanently denied');
    }
  }

  Future<void> _getLocation() async {
    if (TargetPlatform.android == true) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
                "Example app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ));
    } else if (true == TargetPlatform.iOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        allowBackgroundLocationUpdates: true,
        timeLimit: Duration(milliseconds: 100),
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        showBackgroundLocationIndicator: true,
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        data.latitude = position.latitude;
        data.longitude = position.longitude;
        print('=====Loc=====');
        print(position.latitude);
        print(position.longitude);
        print('=====Loc=====');
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    await _requestLocation();
    await _requestPermission();
    await _getWalk();
  }

  _getWalk() async {
    try {
      var res = await ScoreApi().getStep("WALK", "WALK_01");
      res != null ? walk = res : walk.balanceAmount = 0;
      print(walk.balanceAmount);
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
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  _requestPermission() async {
    final PermissionStatus status =
        await Permission.activityRecognition.request();
    print(status);
    if (status == PermissionStatus.granted) {
      initSteps();
    } else {
      initSteps();
    }
  }

  void initSteps() {
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
            data.amount = stepsSinceLastEvent.toString();
            stepped += stepsSinceLastEvent;
            if (previousStepCount != null && stepsSinceLastEvent != 0) {
              ScoreApi().sendStep(data);
            }
            step = stepsSinceLastEvent.toString();
          });
        }
      },
    );
  }

  onRedeem() async {
    try {
      setState(() {
        isButtonLoad = true;
      });
      var res = await ScoreApi().onRedeem(walk.id!);
      _getWalk();
      print(res);
      setState(() {
        isButtonLoad = false;
      });
    } catch (e) {
      setState(() {
        isButtonLoad = false;
      });
      print(e.toString());
    }
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
                    isLoading == false
                        ? walk.balanceAmount != null && walk.balanceAmount != 0
                            ? '${stepped}'
                            : '0'
                        : "-",
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
          SizedBox(
            height: 15,
          ),
          CustomButton(
            labelText: 'Урамшуулал авах',
            height: 40,
            buttonColor: greentext,
            isLoading: isButtonLoad,
            onClick: () {
              onRedeem();
            },
            textColor: white,
          ),
        ],
      ),
    );
  }
}
