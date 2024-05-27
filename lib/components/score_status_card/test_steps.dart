 // void _requestPermission() async {
  //   final PermissionStatus status =
  //       await Permission.activityRecognition.request();
  //   print(status);
  //   if (status == PermissionStatus.granted) {
  //     initSteps();
  //   } else if (status == PermissionStatus.denied) {
  //     // Permission denied, prompt the user to grant it again
  //     final bool secondTry = await showDialog(
  //       context: context, // Replace 'context' with your BuildContext
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Permission Needed'),
  //           content:
  //               Text('Please grant permission to access activity recognition.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, true),
  //               child: Text('Try Again'),
  //             ),
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, false),
  //               child: Text('Cancel'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     if (secondTry) {
  //       _requestPermission();
  //     } else {
  //       print('Permission denied');
  //     }
  //   }
  // }
  // void initStep() {
  //   subscription = Pedometer.stepCountStream.listen(
  //     (event) {
  //       print('===EVENT=====');
  //       print(event);
  //       print('===EVENT=====');
  //       setState(() {
  //         step = event.steps.toString();
  //       });
  //     },
  //   );
  // }

  // @override
  // void dispose() {
  //   // _startListeningStep();
  //   // subscription?.cancel();
  //   super.dispose();
  // }

  // void _startListening() async {
  //   subscription = Pedometer.stepCountStream.listen(
  //     (event) {
  //       if (isToday(event.timeStamp)) {
  //         setState(() {
  //           todaysSteps = event.steps;
  //         });
  //       }
  //       print('===EVENT=====');
  //       print(isToday(event.timeStamp));
  //       print('===EVENT=====');
  //       setState(() {
  //         todaysSteps = event.steps.toInt();
  //       });
  //     },
  //   );
  // }

  // bool isToday(DateTime dateTime) {
  //   DateTime now = DateTime.now();
  //   return now.year == dateTime.year &&
  //       now.month == dateTime.month &&
  //       now.day == dateTime.day;
  // }

  // initIosHealth() async {
  //   Timer.periodic(Duration(seconds: 1), (timer) async {
  //     HealthFactory health = HealthFactory();
  //     var types = [HealthDataType.STEPS];
  //     var permissions = [HealthDataAccess.READ];

  //     bool requested =
  //         await health.requestAuthorization(types, permissions: permissions);
  //     if (requested) {
  //       final now = DateTime.now();
  //       final todayStart = DateTime(now.year, now.month, now.day);
  //       final todayEnd =
  //           todayStart.add(Duration(days: 1)).subtract(Duration(seconds: 1));
  //       try {
  //         var qwerty =
  //             await health.getHealthDataFromTypes(todayEnd, todayEnd, types);
  //         print(qwerty);
  //         int? stepsTd =
  //             await health.getTotalStepsInInterval(todayStart, todayEnd);
  //         setState(() {
  //           stepIos = stepsTd!;
  //         });
  //         print("Today's steps: $stepsTd");
  //       } catch (error) {
  //         print(error);
  //       }
  //     } else {
  //       print('=======Auth not granted======');
  //     }
  //   });
  // }

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
  // int stepforIOS = 0;

  // static const platform = const MethodChannel('step_counter_channel');

  // void _startListeningStep() async {
  //   Timer.periodic(Duration(seconds: 1), (timer) async {
  //     try {
  //       final int result = await platform.invokeMethod('startListening');
  //       print('======STEPFORIOS=====');
  //       print(result);
  //       if (mounted) {
  //         setState(() {
  //           stepforIOS += result;
  //         });
  //       }
  //       print('======STEPFORIOS=====');
  //     } on PlatformException catch (e) {
  //       print("Failed to start listening: '${e.message}'.");
  //     }
  //   });
  // }


  //TEST FROM FIX CARD
  // _requestLocation() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   final PermissionStatus status = await Permission.locationAlways.request();

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.denied) {
  //       await _getLocation();
  //     }
  //   }
  //   if (status == PermissionStatus.granted) {
  //     await _getLocation();
  //   } else if (status == PermissionStatus.denied) {
  //     print('Permission denied');
  //   } else if (status == PermissionStatus.permanentlyDenied) {
  //     await _getLocation();
  //     print('Permission permanently denied');
  //   }
  // }

  // Future<void> _getLocation() async {
  //   if (TargetPlatform.android == true) {
  //     locationSettings = AndroidSettings(
  //         accuracy: LocationAccuracy.high,
  //         distanceFilter: 100,
  //         forceLocationManager: true,
  //         intervalDuration: const Duration(seconds: 10),
  //         foregroundNotificationConfig: const ForegroundNotificationConfig(
  //           notificationText:
  //               "Example app will continue to receive your location even when you aren't using it",
  //           notificationTitle: "Running in Background",
  //           enableWakeLock: true,
  //         ));
  //   } else if (true == TargetPlatform.iOS) {
  //     locationSettings = AppleSettings(
  //       accuracy: LocationAccuracy.high,
  //       allowBackgroundLocationUpdates: true,
  //       timeLimit: Duration(milliseconds: 100),
  //       activityType: ActivityType.fitness,
  //       distanceFilter: 100,
  //       pauseLocationUpdatesAutomatically: true,
  //       showBackgroundLocationIndicator: true,
  //     );
  //   } else {
  //     locationSettings = LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //       distanceFilter: 100,
  //     );
  //   }

  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     setState(() {
  //       data.latitude = position.latitude;
  //       data.longitude = position.longitude;
  //       print('=====Loc=====');
  //       print(position.latitude);
  //       print(position.longitude);
  //       print('=====Loc=====');
  //     });
  //   } catch (e) {
  //     print("Error getting location: $e");
  //   }
  // }