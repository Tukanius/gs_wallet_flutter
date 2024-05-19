// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_score/api/score_api.dart';
import 'package:green_score/components/action_button/action_button.dart';
import 'package:green_score/components/trade_bottom_sheet/trade_bottom_sheet.dart';
import 'package:green_score/models/location_info.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/src/collect_score_page/score_page.dart';
import 'package:green_score/src/home_page/home_page.dart';
import 'package:green_score/src/notification_page/notification_page.dart';
import 'package:green_score/src/profile_page/profile_page.dart';
import 'package:green_score/src/qr_code_page/qr_read_page.dart';
// import 'package:green_score/src/trade_page/trade_page.dart';
import 'package:green_score/src/wallet_page/wallet_page.dart';
import 'package:green_score/widget/ui/backgroundshapes.dart';
import 'package:green_score/widget/ui/color.dart';
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
    with SingleTickerProviderStateMixin {
  User user = User();
  bool _isKeyboardVisible = false;

  int currentIndex = 0;
  late TabController tabController;
  late LocationSettings locationSettings;

  @override
  void initState() {
    super.initState();
    requestPermission();
    // initializeService();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabSelection);
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
  }

  _handleTabSelection() {
    setState(() {
      currentIndex = tabController.index;
    });
  }

  requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    final PermissionStatus status = await Permission.location.request();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        // startTrack();
        await initializeService();
      }
    }

    if (status == PermissionStatus.granted) {
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      // startTrack();
      await initializeService();
      print('Permission permanently denied');
    }
  }

  // Future<void> startTrack() async {
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

  //   Timer.periodic(
  //     Duration(milliseconds: 10000),
  //     (timer) async {
  //       try {
  //         Position position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high,
  //         );
  //         LocationInfo info = LocationInfo(
  //           latitude: position.latitude,
  //           longitude: position.longitude,
  //           timestamp: position.timestamp.toString(),
  //           accuracy: position.accuracy,
  //           altitude: position.altitude,
  //           altitudeAccuracy: position.altitudeAccuracy,
  //           heading: position.heading,
  //           headingAccuracy: position.headingAccuracy,
  //           speed: position.speed,
  //           speedAccuracy: position.speedAccuracy,
  //         );
  //         try {
  //           var res = await ScoreApi().trackLocation(info);
  //           print(res);
  //         } catch (e) {
  //           print("Error sending location: $e");
  //         }
  //       } catch (e) {
  //         print("Error getting location: $e");
  //       }
  //     },
  //   );
  // }

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
                          Positioned(
                            top: 0,
                            right: 0,
                            child: SvgPicture.asset('assets/svg/notnumber.svg'),
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
                        svgAssetPath: "assets/svg/qr.svg",
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
                    // height: Platform.isAndroid ? 60 : 90,
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
      initialNotificationContent: 'Total Step 123',
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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  bool isForeground = false;

  Timer.periodic(const Duration(seconds: 10), (timer) async {
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
    if (Platform.isAndroid) {
      if (isForeground) {
        flutterLocalNotificationsPlugin.show(
          888,
          'COOL SERVICE',
          'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    }

    print('FLUTTER BACKGROUND SERVICE:  TEST');
  });

  service.on('data').listen((event) {
    final message = event;
    if (message == 'setAsForeground') {
      isForeground = true;
    } else if (message == 'setAsBackground') {
      isForeground = false;
    }
  });
}
