import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
// import 'package:green_score/models/notify.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/services/dialog.dart';
import 'package:green_score/services/navigation.dart';
import 'package:green_score/services/notify_service.dart';
import 'package:green_score/src/splash_screen/splash_screen.dart';
// import 'package:green_score/services/navigation.dart';
// import 'package:green_score/src/splash_screen/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'http_handler.dart';
import '../main.dart';
// import 'package:green_score/src/splash_screen/splash_screen.dart';
// import 'package:green_score/services/navigation.dart';

class HttpRequest {
  static const gsAuth = 'https://gs.zto.mn/aut';
  // static const gsAuth = 'http://192.168.1.15:30820';x

  static const gsMedia = 'https://gs.zto.mn/mdi';
  // static const gsMedia = 'http://192.168.1.15:30821';

  static const gsMerchant = 'https://gs.zto.mn/mer';
  // static const gsMerchant = 'http://192.168.1.15:30823';

  static const gsUser = 'https://gs.zto.mn/urs';
  // static const gsUser = 'http://192.168.1.15:30824';

  static const gsWallet = 'https://gs.zto.mn/wal';
  // static const gsWallet = 'http://192.168.1.15:30825';

  static const gsInvoice = 'https://gs.zto.mn/inv';
  // static const gsInvoice = 'http://192.168.1.15:30822';

  static const gsTransaction = 'https://gs.zto.mn/tra';
  // static const gsTransaction = 'http://192.168.1.15:30827';

  static const gsScore = 'https://gs.zto.mn/sco';
  // static const gsScore = 'http://192.168.1.15:30826';

  static const version = '/api';

  Dio dio = Dio();

  Future<dynamic> request(String api, String method, dynamic data, String? type,
      {bool handler = true, bool approve = false}) async {
    Response? response;
    final String uri;
    var token = await UserProvider.getAccessToken();

    if (type == "AUTH") {
      uri = '$gsAuth$version$api';
    } else if (type == "MEDIA") {
      uri = '$gsMedia$version$api';
    } else if (type == "MERCHANT") {
      uri = '$gsMerchant$version$api';
    } else if (type == "USER") {
      uri = '$gsUser$version$api';
    } else if (type == "WALLET") {
      uri = '$gsWallet$version$api';
    } else if (type == "INVOICE") {
      uri = '$gsInvoice$version$api';
    } else if (type == "TRANSACTION") {
      uri = '$gsTransaction$version$api';
    } else if (type == "SCORE") {
      uri = '$gsScore$version$api';
    } else {
      uri = '$gsAuth$version$api';
    }

    debugPrint(uri);

    debugPrint('+++++++++++++++++++++++++++++++++++++++++++++++++++');
    debugPrint('handler: ' + handler.toString());
    debugPrint('+++++++++++++++++++++++++++++++++++++++++++++++++++ ');

    try {
      Directory dir = await getTemporaryDirectory();
      CookieJar cookieJar =
          PersistCookieJar(storage: FileStorage(dir.path), ignoreExpires: true);

      dio.interceptors.add(CookieManager(cookieJar));

      var token = await UserProvider.getAccessToken();
      var deviceToken = "";
      // debugPrint('++++++++++++++++++++++token++++++++++++++++++');
      // debugPrint(token);
      // debugPrint('++++++++++++++++++++++token++++++++++++++++++');

      dio.options.headers = {
        'authorization': 'Bearer $token',
        'device-token': deviceToken,
        'device_type': 'MOS',
        'device_imei': 'test-imei',
        'device_info': 'iphone 13'
      };
    } catch (err) {
      debugPrint(err.toString());
    }

    if (method != 'GET') {
      debugPrint('body: $data');
    }

    try {
      switch (method) {
        case 'GET':
          {
            response = await dio.get(uri, queryParameters: data);
            break;
          }
        case 'POST':
          {
            response = await dio.post(uri, data: data);
            break;
          }
        case 'PUT':
          {
            response = await dio.put(uri, data: data);
            break;
          }
        case 'DELETE':
          {
            response = await dio.delete(uri, data: data);
            break;
          }
      }

      return HttpHandler(statusCode: response?.statusCode).handle(response);
    } on DioException catch (ex) {
      if (token != null && ex.response?.statusCode == 401) {
        print('====TOKEN from Green score====');
        print(token);
        print('====TOKEN from Green score====');

        MyApp.setInvalidToken(MyApp.invalidTokenCount + 1);
        if (MyApp.invalidTokenCount == 1) {
          await UserProvider().auth();
          locator<NavigationService>()
              .pushNamed(routeName: SplashScreen.routeName);
          NotifyService().showNotification(
            title: 'Green Score',
            body: 'Нэвтрэх эрх хүчингүй боллоо',
          );

          MyApp.setInvalidToken(0);

          return null;
        }
        return;
      }
      // if (token != null && ex.response?.statusCode == 401) {
      //   print('SOOOOOOO ITS GOT DOOMED');
      //   // locator<DialogService>().showErrorDialogListener("Нэвтэрнэ үү");
      //   // navigatorKey.currentState?.pushNamed('SplashScreen');

      //   // MyApp.setInvalidToken(MyApp.invalidTokenCount + 1);
      //   // if (MyApp.invalidTokenCount == 1) {
      //   //   await UserProvider().auth();
      //   //   locator<NavigationService>()
      //   //       .pushNamed(routeName: SplashScreen.routeName);

      //   //   // NotificationService notificationService =
      //   //   //     locator<NotificationService>();
      //   //   locator<DialogService>().showErrorDialogListener("Нэвтэрнэ үү");

      //   //   // notificationService.registerShowNotificationListener(
      //   //   //     "EV Loyalty", "Нэвтрэх эрх хүчингүй боллоо.");
      //   //   MyApp.setInvalidToken(0);

      //   //   return null;
      //   // }
      //   // return;
      // }
      // if (token != null && ex.response?.statusCode == 401) {
      //   print('qweqweqwe');
      //   if (!_isNavigating) {
      //     _isNavigating = true;
      //     navigatorKey.currentState?.pushNamed('SplashScreen').then((_) {
      //       locator<DialogService>().showErrorDialogListener("Please log in");
      //       _isNavigating = false;
      //     });
      //   }
      //   return;
      // }
      HttpHandler? error =
          HttpHandler(statusCode: ex.response?.statusCode).handle(ex.response);

      if (handler == true && error!.message != null) {
        final DialogService dialogService = locator<DialogService>();
        dialogService.showErrorDialog(error.message.toString());
      }

      throw error!;
    }
  }

  Future<dynamic> get(String url, String type,
      {dynamic data, bool handler = true}) async {
    try {
      return await request(url, 'GET', data, type, handler: handler);
    } catch (e) {
      debugPrint("GET =>$e");
      rethrow;
    }
  }

  Future<dynamic> post(String url, String type,
      {dynamic data, bool handler = true, bool approve = false}) async {
    try {
      return await request(
        url,
        'POST',
        data,
        type,
        handler: handler,
        approve: approve,
      );
    } catch (e) {
      debugPrint("POST =>$e");
      rethrow;
    }
  }

  Future<dynamic> put(String url, String type,
      {dynamic data, bool handler = true}) async {
    try {
      return await request(url, 'PUT', data, type, handler: handler);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> del(String url, String type,
      {dynamic data, bool handler = true}) async {
    return await request(url, 'DELETE', data, type, handler: handler);
  }
}
