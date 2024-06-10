// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:green_score/main.dart';

// class FireBaseApi {
//   final _firebaseMessagin = FirebaseMessaging.instance;

//   Future<void> initNotifications() async {
//     await _firebaseMessagin.requestPermission();
//     final fcmToken = await _firebaseMessagin.getToken();

//     print(' TOKEN: $fcmToken');
//     initPushNotifications();
//   }

//   void handleMessage(RemoteMessage? message) {
//     if (message == null) return;
//     navigatorKey.currentState?.pushNamed(
//       'SplashScreen', 
//       arguments: message,
//     );
//   }

//   Future initPushNotifications() async {
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   }
// }
