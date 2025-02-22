// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyArXv4nL_C0JWkcP07WqKU9eu2JJcOicBA',
    appId: '1:812928312106:web:89499bf9215ae5cd5bf453',
    messagingSenderId: '812928312106',
    projectId: 'eto-gg',
    authDomain: 'eto-gg.firebaseapp.com',
    databaseURL: 'https://eto-gg.firebaseio.com',
    storageBucket: 'eto-gg.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwrFjJer0DRhZQPmQfi1ZQRRGBwQsyQzc',
    appId: '1:408063878237:android:8c207bf8430cf2165959b4',
    messagingSenderId: '408063878237',
    projectId: 'green-score-nature',
    storageBucket: 'green-score-nature.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBte6MP_7q1dBPeaZoupZKNdSnIbzmHAig',
    appId: '1:408063878237:ios:8ceb49c90cd6429b5959b4',
    messagingSenderId: '408063878237',
    projectId: 'green-score-nature',
    storageBucket: 'green-score-nature.appspot.com',
    iosBundleId: 'gs.app.flutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuBc-BLt3p-jRORaLOVSMA2qcRFE3W2c4',
    appId: '1:812928312106:ios:a06f8dbf5177993e5bf453',
    messagingSenderId: '812928312106',
    projectId: 'eto-gg',
    databaseURL: 'https://eto-gg.firebaseio.com',
    storageBucket: 'eto-gg.appspot.com',
    iosBundleId: 'com.example.greenScore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyArXv4nL_C0JWkcP07WqKU9eu2JJcOicBA',
    appId: '1:812928312106:web:e3b18b967f4033725bf453',
    messagingSenderId: '812928312106',
    projectId: 'eto-gg',
    authDomain: 'eto-gg.firebaseapp.com',
    databaseURL: 'https://eto-gg.firebaseio.com',
    storageBucket: 'eto-gg.appspot.com',
  );
}