// import 'dart:async';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   Function getContextListener;
//   Function(String) showNotification;
//   Completer noficationCompleter;
//   FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

//   AndroidNotificationChannel channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       'This channel is used for important notifications.', // description
//       importance: Importance.high,
//       playSound: true);

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void registerShowNotificationListener(String title, String body) async {
//     var androidInit =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iOSinit = IOSInitializationSettings(
//         onDidReceiveLocalNotification:
//             (int id, String title, String body, String payload) {});
//     var initializationSettings =
//         InitializationSettings(android: androidInit, iOS: iOSinit);
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (value) {});

//     noficationCompleter = Completer();
//     // showNotification = showDialogListener;

//     var androidDetails = AndroidNotificationDetails(
//         channel.id, channel.name, channel.description,
//         importance: Importance.max, icon: "@mipmap/ic_launcher");
//     var iOSDetails = const IOSNotificationDetails();
//     var generalNotificationDetails =
//         NotificationDetails(android: androidDetails, iOS: iOSDetails);

//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       generalNotificationDetails,
//     );
//   }
// }
