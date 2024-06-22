// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_score/api/score_api.dart';
import 'package:green_score/models/accumlation.dart';
import 'package:green_score/provider/loading_provider.dart';
import 'package:green_score/provider/socket_provider.dart';
import 'package:green_score/api/user_api.dart';
import 'package:green_score/components/action_button/action_button.dart';
import 'package:green_score/components/trade_bottom_sheet/trade_bottom_sheet.dart';
// import 'package:green_score/models/accumlation.dart';
import 'package:green_score/models/location_info.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/tools_provider.dart';
// import 'package:green_score/provider/tools_provider.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/score_page/score_page.dart';
import 'package:green_score/src/home_page/home_page.dart';
import 'package:green_score/src/notification_page/notification_page.dart';
import 'package:green_score/src/profile_page/profile_page.dart';
import 'package:green_score/src/qr_code_page/qr_read_page.dart';
// import 'package:green_score/src/trade_page/trade_page.dart';
import 'package:green_score/src/wallet_page/wallet_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
import 'package:pedometer/pedometer.dart';
// import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  static const routeName = "MainPage";
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  User user = User();
  bool _isKeyboardVisible = false;
  bool isLoading = false;
  int currentIndex = 1;
  int count = 0;
  late TabController tabController;
  late LocationSettings locationSettings;
  late ScrollController _scrollController;

  Accumlation walk = Accumlation();
  Accumlation scooter = Accumlation();

  List<double> stepsForLast7Days = List<double>.filled(7, 0.0);
  late StreamSubscription<StepCount> subscription;

  requestMotionForAndroid() async {
    try {
      PermissionStatus status = await Permission.activityRecognition.request();
      print('===========STEP FOR ANDROID PERMISSION========');
      print(status);
      print('===========STEP FOR ANDROID PERMISSION========');
      if (status == PermissionStatus.granted) {
        calculateStep();
      } else if (status == PermissionStatus.denied) {
        PermissionStatus retryStatus = await Permission.sensors.request();
        if (retryStatus == PermissionStatus.granted) {
          calculateStep();
        } else if (retryStatus == PermissionStatus.permanentlyDenied) {
          print(
              'Permission permanently denied. Please enable it from settings.');
          openAppSettings();
        } else {
          print('Can not calculate steps!!!');
        }
      } else if (status == PermissionStatus.permanentlyDenied) {
        print('Permission permanently denied. Please enable it from settings.');
        openAppSettings();
      } else {
        print('Can not calculate steps!!!');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  requestMotionForIos() async {
    try {
      PermissionStatus status = await Permission.sensors.request();
      print('===========STEP FOR IOS PERMISSION========');
      print(status);
      print('===========STEP FOR IOS PERMISSION========');

      if (status == PermissionStatus.granted) {
        calculateStep();
      } else if (status == PermissionStatus.denied) {
        PermissionStatus retryStatus = await Permission.sensors.request();
        if (retryStatus == PermissionStatus.granted) {
          calculateStep();
        } else if (retryStatus == PermissionStatus.permanentlyDenied) {
          print(
              'Permission permanently denied. Please enable it from settings.');
          openAppSettings();
        } else {
          print('Can not calculate steps!!!');
        }
      } else if (status == PermissionStatus.permanentlyDenied) {
        print('Permission permanently denied. Please enable it from settings.');
        openAppSettings();
      } else {
        print('Can not calculate steps!!!');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  afterFirstLayout(BuildContext context) async {
    Platform.isAndroid
        ? await requestMotionForAndroid()
        : Platform.isIOS
            ? await requestMotionForIos()
            : await requestMotionForAndroid();
    await requestLocation();

    final loading = Provider.of<LoadingProvider>(context, listen: false);
    final tools = Provider.of<ToolsProvider>(context, listen: false);

    try {
      setState(() {
        isLoading = true;
      });
      loading.loading(true);
      walk.type = "WALK";
      walk.code = "WALK_01";
      walk = await ScoreApi().getStep(walk);
      scooter.type = "COMMUNITY";
      scooter.code = "SCOOTER_01";
      scooter = await ScoreApi().getStep(scooter);
      walk.lastWeekTotal != null
          ? stepsForLast7Days = walk.lastWeekTotal!
              .map((data) => data.totalAmount!.toDouble())
              .toList()
          : List<double>.filled(7, 0.0);

      tools.thresholdUpdate(walk.green!.threshold!);
      tools.updateSteps(stepsForLast7Days);
      tools.updateId(walk.id!);
      tools.updatewalkDescription(
          '${walk.green?.threshold} алхам = ${walk.green?.scoreAmount}GS');
      tools.updatescooterDescription(
          '${scooter.green?.threshold} төг = ${scooter.green?.scoreAmount}GS');

      if (walk.balanceAmount == 0 || walk.balanceAmount == null) {
        tools.setStepped(0);
      } else {
        print('===PROVIDERSTEP=====');
        print(walk.balanceAmount);
        print('===PROVIDERSTEP=====');
        tools.setStepped(walk.balanceAmount!);
      }
      count = await UserApi().getNotCount();
      loading.loading(false);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      loading.loading(false);

      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void calculateStep() async {
    Accumlation sendWalk = Accumlation();
    int? previousStepCount;
    final tool = Provider.of<ToolsProvider>(context, listen: false);
    final socket = Provider.of<SocketProvider>(context, listen: false);

    subscription = Pedometer.stepCountStream.listen(
      (event) async {
        int currentStepCount = event.steps;
        int stepsSinceLastEvent = previousStepCount != null
            ? currentStepCount - previousStepCount!
            : 0;
        previousStepCount = currentStepCount;

        if (stepsSinceLastEvent > 0) {
          tool.addDifference(stepsSinceLastEvent);
        }
        setState(() {
          tool.addSteps(stepsSinceLastEvent);
          print('=====ULDEGDEL====');
          print(tool.accumulatedSteps);
          print('=====ULDEGDEL====');
        });
        if (tool.accumulatedSteps > 20) {
          sendWalk.amount = tool.accumulatedSteps;
          tool.accumulatedSteps = tool.accumulatedSteps - tool.accumulatedSteps;
          if (previousStepCount != null) {
            await socket.sendStep(sendWalk.amount!, 0, 0);
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    print('=====HELO=======');
    print('${Provider.of<UserProvider>(context, listen: false).myToken}');
    print('=====HELO=======');

    Provider.of<SocketProvider>(context, listen: false).initSocket(
        '${Provider.of<UserProvider>(context, listen: false).myToken}');
    // requestStep();
    // initializeService();
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    tabController.addListener(_handleTabSelection);
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    setState(() {
      currentIndex = tabController.index;
      _scrollController.jumpTo(0);
    });
  }

  requestLocation() async {
    await Future.delayed(const Duration(seconds: 3));
    LocationPermission permission = await Geolocator.checkPermission();
    final PermissionStatus status = await Permission.location.request();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        await initializeService();
      }
    }
    print('====LOCATION STATUS====');
    print(status);
    print('====LOCATION STATUS====');

    if (status == PermissionStatus.granted) {
      await initializeService();
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission permanently denied');
      await initializeService();
    }
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context, listen: true).user;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PopScope(
        canPop: false,
        child: KeyboardVisibilityProvider(
          child: BackgroundShapes(
            body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxisScrolled) {
                return <Widget>[
                  SliverAppBar(
                    toolbarHeight: 60,
                    automaticallyImplyLeading: false,
                    pinned: false,
                    snap: true,
                    floating: true,
                    elevation: 0,
                    backgroundColor: transparent,
                    actions: [
                      Stack(
                        children: [
                          count == 0
                              ? SizedBox()
                              : Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/svg/notnumber.svg'),
                                      Text(
                                        '${count}',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          Center(
                            child: ActionButton(
                              svgAssetPath: "assets/svg/notification.svg",
                              onClick: () {
                                Navigator.of(context)
                                    .pushNamed(NotificationPage.routeName);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                        svgAssetPath: "assets/svg/qrScan.svg",
                        onClick: () {
                          Navigator.of(context).pushNamed(QrReadPage.routeName);
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                    centerTitle: false,
                    title: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ProfilePage.routeName);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: user.avatar != null
                              ? CircleAvatar(
                                  radius: 22,
                                  backgroundImage:
                                      NetworkImage('${user.avatar}'),
                                  backgroundColor: greytext,
                                )
                              : SvgPicture.asset(
                                  'assets/svg/avatar.svg',
                                  height: 44,
                                  width: 44,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: FocusScope(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    HomePage(),
                    ScorePage(),
                    WalletPage(),
                    // TradePage(),
                  ],
                ),
              ),
            ),
            extendBody: true,
            bottomNavigationBar: !_isKeyboardVisible
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: bottomnavcolor,
                    ),
                    alignment: Alignment.topCenter,
                    child: TabBar(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 10),
                      indicator: BoxDecoration(),
                      dividerColor: transparent,
                      controller: tabController,
                      tabs: <Widget>[
                        Tab(
                          icon: SvgPicture.asset(
                            "assets/svg/home.svg",
                            height: 30,
                            width: 30,
                            color: currentIndex == 0 ? greentext : white,
                          ),
                        ),
                        Tab(
                          icon: SvgPicture.asset(
                            "assets/svg/leaf.svg",
                            height: 30,
                            width: 30,
                            color: currentIndex == 1 ? greentext : white,
                          ),
                        ),
                        Tab(
                          icon: SvgPicture.asset(
                            "assets/svg/wallet.svg",
                            height: 30,
                            width: 30,
                            color: currentIndex == 2 ? greentext : white,
                          ),
                        ),
                        // Tab(
                        //   icon: SvgPicture.asset(
                        //     "assets/svg/transfer.svg",
                        //     height: 30,
                        //     width: 30,
                        //     color: currentIndex == 3 ? greentext : white,
                        //   ),
                        // ),
                      ],
                    ),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: currentIndex == 3
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              trade(context, "1");
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: red,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/svg/sell_button.svg'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Зарах',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              trade(context, "2");
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: greentext,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/svg/buy_button.svg'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Авах',
                                    style: TextStyle(color: white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

initializeService() async {
  final service = FlutterBackgroundService();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground',
    'MY FOREGROUND SERVICE',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'Green Score',
      initialNotificationContent: 'Track Step',
      foregroundServiceNotificationId: 888,
      autoStartOnBoot: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

void onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bool isForeground = false;
  Timer.periodic(const Duration(seconds: 60), (timer) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      LocationInfo info = LocationInfo(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: position.timestamp.toString(),
        accuracy: position.accuracy,
        altitude: position.altitude,
        altitudeAccuracy: position.altitudeAccuracy,
        heading: position.heading,
        headingAccuracy: position.headingAccuracy,
        speed: position.speed,
        speedAccuracy: position.speedAccuracy,
      );
      try {
        var res = await ScoreApi().trackLocation(info);
        print(res);
      } catch (e) {
        print("Error sending location: $e");
      }
    } catch (e) {
      print("Error getting location: $e");
    }
    // if (Platform.isAndroid) {
    //   if (isForeground) {
    //     flutterLocalNotificationsPlugin.show(
    //       888,
    //       'COOL SERVICE',
    //       'Awesome ${DateTime.now()}',
    //       const NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           'my_foreground',
    //           'MY FOREGROUND SERVICE',
    //           icon: '@mipmap/launcher_icon',
    //           ongoing: true,
    //         ),
    //       ),
    //     );
    //   }
    // }

    print('FLUTTER BACKGROUND SERVICE:  TEST');
  });

  service.on('data').listen((event) {
    // final message = event;
    // if (message == 'setAsForeground') {
    //   isForeground = true;
    // } else if (message == 'setAsBackground') {
    //   isForeground = false;
    // }
  });
}
