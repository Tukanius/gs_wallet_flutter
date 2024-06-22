// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_score/provider/loading_provider.dart';
import 'package:green_score/provider/socket_provider.dart';
import 'package:green_score/firebase_options.dart';
import 'package:green_score/provider/tools_provider.dart';
// import 'package:green_score/provider/tools_provider.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/services/dialog.dart';
import 'package:green_score/services/navigation.dart';
import 'package:green_score/src/auth/forget_password_page.dart';
import 'package:green_score/src/auth/login_page.dart';
import 'package:green_score/src/auth/otp_page.dart';
import 'package:green_score/src/auth/password_page.dart';
import 'package:green_score/src/auth/register_page.dart';
import 'package:green_score/services/notify_service.dart';
import 'package:green_score/src/profile_page/dan_verify_page/user_detail_page.dart';
import 'package:green_score/src/score_page/all_opportunity_page.dart';
import 'package:green_score/src/score_page/collect_score_page/collect_scooter_page.dart';
import 'package:green_score/src/score_page/collect_score_page/collect_step_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/autobus_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/sale_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/school_card_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/scooter_detail_page.dart';
import 'package:green_score/src/score_page/opportunities_pages/step_detail_page.dart';
import 'package:green_score/src/home_page/company_page/company_page.dart';
import 'package:green_score/src/home_page/company_page/map_page.dart';
import 'package:green_score/src/home_page/product_detail_page/product_detail_page.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/src/notification_page/notification_detail.dart';
import 'package:green_score/src/notification_page/notification_page.dart';
import 'package:green_score/src/profile_page/profile_edit_page/camera_page.dart';
import 'package:green_score/src/profile_page/dan_verify_page/dan_verify_page.dart';
import 'package:green_score/src/profile_page/profile_edit_page/profile_edit_page.dart';
import 'package:green_score/src/profile_page/profile_page.dart';
import 'package:green_score/src/qr_code_page/confirm_payment.dart';
import 'package:green_score/src/qr_code_page/qr_read_page.dart';
import 'package:green_score/src/qr_code_page/qr_check.dart';
import 'package:green_score/src/splash_screen/splash_screen.dart';
import 'package:green_score/src/trade_page/trade_page.dart';
import 'package:green_score/src/wallet_page/card_detail_page/card_detail_page.dart';
import 'package:green_score/src/wallet_page/wallet_page.dart';
import 'package:green_score/widget/dialog_manager/dialog_manager.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotifyService().initNotify();
  // await FireBaseApi().initNotifications();
  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   if (message != null) {
  //     print("Received message: ${message.messageId}");
  //   }
  // });

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print("Received message: ${message.messageId}");
  //   // Handle foreground messages
  // });

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print("Tapped notification: ${message.messageId}");
  //   // Handle tapping on the notification
  // });

  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

final navigatorKey = GlobalKey<NavigatorState>();
GetIt locator = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ToolsProvider()),
        ChangeNotifierProvider(create: (_) => SocketProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return MaterialApp(
            builder: (context, widget) => Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) =>
                    DialogManager(child: loading(context, widget)),
              ),
            ),
            title: 'Green Score',
            theme: ThemeData(useMaterial3: true),
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.routeName,
            navigatorKey: navigatorKey,
            routes: {
              'NotificationPage': (context) => const NotificationPage(),
              'SplashScreen': (context) => const SplashScreen(),
            },
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case SplashScreen.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const SplashScreen();
                  });
                case RegisterPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const RegisterPage();
                  });
                case MainPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const MainPage();
                  });
                case LoginPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  });
                case AllOpportunityPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const AllOpportunityPage();
                  });
                case WalletPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const WalletPage();
                  });
                case TradePage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const TradePage();
                  });
                case ConfirmQrCodePage.routeName:
                  ConfirmQrCodePageArguments arguments =
                      settings.arguments as ConfirmQrCodePageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return ConfirmQrCodePage(
                      data: arguments.data,
                    );
                  });
                case NotificationPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const NotificationPage();
                  });
                case QrReadPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const QrReadPage();
                  });
                case ForgetPassword.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const ForgetPassword();
                  });
                case DanVerifyPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const DanVerifyPage();
                  });
                case UserDetailPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const UserDetailPage();
                  });
                case CollectStepScore.routeName:
                  CollectStepScoreArguments arguments =
                      settings.arguments as CollectStepScoreArguments;
                  return MaterialPageRoute(builder: (context) {
                    return CollectStepScore(
                      id: arguments.id,
                      pushWhere: arguments.pushWhere,
                    );
                  });
                case MapPage.routeName:
                  MapPageArguments arguments =
                      settings.arguments as MapPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return MapPage(
                      lang: arguments.lang,
                      long: arguments.long,
                    );
                  });
                case PassWordPage.routeName:
                  PassWordPageArguments arguments =
                      settings.arguments as PassWordPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return PassWordPage(
                      method: arguments.method,
                    );
                  });
                case ProfilePage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const ProfilePage();
                  });
                // case ProfilePage.routeName:
                //   return PageRouteBuilder(
                //     pageBuilder: (context, animation, secondaryAnimation) =>
                //         const ProfilePage(),
                //     transitionsBuilder:
                //         (context, animation, secondaryAnimation, child) {
                //       var begin = const Offset(-1.0, 0.0);
                //       var end = Offset.zero;
                //       var curve = Curves.ease;

                //       var tween = Tween(begin: begin, end: end)
                //           .chain(CurveTween(curve: curve));

                //       return SlideTransition(
                //         position: animation.drive(tween),
                //         child: child,
                //       );
                //     },
                //   );
                case ProfileEdit.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const ProfileEdit();
                  });
                // case ProfileEdit.routeName:
                //   return PageRouteBuilder(
                //     pageBuilder: (context, animation, secondaryAnimation) =>
                //         const ProfileEdit(),
                //     transitionsBuilder:
                //         (context, animation, secondaryAnimation, child) {
                //       var begin = const Offset(-1.0, 0.0);
                //       var end = Offset.zero;
                //       var curve = Curves.ease;

                //       var tween = Tween(begin: begin, end: end)
                //           .chain(CurveTween(curve: curve));

                //       return SlideTransition(
                //         position: animation.drive(tween),
                //         child: child,
                //       );
                //     },
                //   );
                case QrTransferPage.routeName:
                  QrTransferPageArguments arguments =
                      settings.arguments as QrTransferPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return QrTransferPage(
                      data: arguments.data,
                    );
                  });
                case CameraPage.routeName:
                  CameraPageArguments arguments =
                      settings.arguments as CameraPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return CameraPage(
                      listenController: arguments.listenController,
                    );
                  });
                case CardDetailPage.routeName:
                  CardDetailPageArguments arguments =
                      settings.arguments as CardDetailPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return CardDetailPage(
                      data: arguments.data,
                    );
                  });
                case ProductDetail.routeName:
                  ProductDetailArguments arguments =
                      settings.arguments as ProductDetailArguments;
                  return MaterialPageRoute(builder: (context) {
                    return ProductDetail(
                      data: arguments.data,
                    );
                  });
                case OtpPage.routeName:
                  OtpPageArguments arguments =
                      settings.arguments as OtpPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return OtpPage(
                      method: arguments.method,
                      username: arguments.username,
                    );
                  });
                case CompanyPage.routeName:
                  CompanyPageArguments arguments =
                      settings.arguments as CompanyPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return CompanyPage(
                      data: arguments.data,
                    );
                  });
                case StepDetailPage.routeName:
                  StepDetailPageArguments arguments =
                      settings.arguments as StepDetailPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return StepDetailPage(
                      title: arguments.title,
                      assetPath: arguments.assetPath,
                    );
                  });
                case ScooterDetailPage.routeName:
                  ScooterDetailPageArguments arguments =
                      settings.arguments as ScooterDetailPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return ScooterDetailPage(
                      title: arguments.title,
                      assetPath: arguments.assetPath,
                    );
                  });
                case SaleDetailPage.routeName:
                  SaleDetailPageArguments arguments =
                      settings.arguments as SaleDetailPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return SaleDetailPage(
                      title: arguments.title,
                      assetPath: arguments.assetPath,
                    );
                  });
                case AutobusDetailPage.routeName:
                  AutobusDetailPageArguments arguments =
                      settings.arguments as AutobusDetailPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return AutobusDetailPage(
                      title: arguments.title,
                      assetPath: arguments.assetPath,
                    );
                  });
                case SchoolCardPage.routeName:
                  SchoolCardPageArguments arguments =
                      settings.arguments as SchoolCardPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return SchoolCardPage(
                      title: arguments.title,
                      assetPath: arguments.assetPath,
                    );
                  });
                case NotificationDetailPage.routeName:
                  NotificationDetailPageArguments arguments =
                      settings.arguments as NotificationDetailPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return NotificationDetailPage(
                      listenController: arguments.listenController,
                      data: arguments.data,
                    );
                  });
                case CollectScooterScore.routeName:
                  CollectScooterScoreArguments arguments =
                      settings.arguments as CollectScooterScoreArguments;
                  return MaterialPageRoute(builder: (context) {
                    return CollectScooterScore(
                      id: arguments.id,
                    );
                  });
                default:
                  return MaterialPageRoute(
                    builder: (_) => const SplashScreen(),
                  );
              }
            },
          );
        },
      ),
    );
  }
}

Widget loading(BuildContext context, widget) {
  bool shouldPop = false;

  return PopScope(
    canPop: shouldPop,
    child: Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Container(
        color: Colors.blue,
        child: SafeArea(
          bottom: false,
          top: false,
          child: Stack(
            children: [
              Opacity(
                opacity: 1,
                child: Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      widget,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Future<void> _requestLocationPermission() async {
//   LocationPermission permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//   }
//   if (permission == LocationPermission.deniedForever) {
//     _requestLocationPermission();
//   }
//   if (permission != LocationPermission.denied) {
//     await _startLocationUpdates();
//   }
// }

// Future<void> _startLocationUpdates() async {
//   LocationSettings locationSettings = LocationSettings(
//     accuracy: LocationAccuracy.high,
//     distanceFilter: 100,
//   );

//   if (TargetPlatform.android == true) {
//     locationSettings = AndroidSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 100,
//       intervalDuration: const Duration(minutes: 1),
//       forceLocationManager: true,
//       foregroundNotificationConfig: const ForegroundNotificationConfig(
//         notificationText:
//             "Example app will continue to receive your location even when you aren't using it",
//         notificationTitle: "Running in Background",
//         enableWakeLock: true,
//       ),
//     );
//   } else if (TargetPlatform.iOS == true) {
//     locationSettings = AppleSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 100,
//       allowBackgroundLocationUpdates: true,
//       activityType: ActivityType.fitness,
//       pauseLocationUpdatesAutomatically: true,
//       showBackgroundLocationIndicator: true,
//     );
//   }

//   Geolocator.getPositionStream(locationSettings: locationSettings).listen(
//     (Position position) async {
//       LocationInfo info = LocationInfo(
//         latitude: position.latitude,
//         longitude: position.longitude,
//         timestamp: position.timestamp.toString(),
//         accuracy: position.accuracy,
//         altitude: position.altitude,
//         altitudeAccuracy: position.altitudeAccuracy,
//         heading: position.heading,
//         headingAccuracy: position.headingAccuracy,
//         speed: position.speed,
//         speedAccuracy: position.speedAccuracy,
//       );

//       try {
//         var res = await ScoreApi().trackLocation(info);
//         print(res);
//       } catch (e) {
//         print("Error sending location: $e");
//       }
//     },
//   );
// }
