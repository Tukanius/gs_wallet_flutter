import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/services/dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'http_handler.dart';
import '../main.dart';

class HttpRequest {
  // static const host = "http://dev-cb-admin.zto.mn";

  static const gsAuth = 'https://dev-gs.zto.mn/aut';
  // static const gsAuth = 'http://192.168.1.15:30820';

  static const gsMedia = 'https://dev-gs.zto.mn/med';
  // static const gsMedia = 'http://192.168.1.15:30821';

  static const gsMerchant = 'https://dev-gs.zto.mn/mer';
  // static const gsMerchant = 'http://192.168.1.15:30823';

  static const gsUser = 'https://dev-gs.zto.mn/urs';
  // static const gsUser = 'http://192.168.1.15:30824';

  static const gsWallet = 'https://dev-gs.zto.mn/wal';
  // static const gsWallet = 'http://192.168.1.15:30825';

  static const gsInvoice = 'https://dev-gs.zto.mn/inv';
  // static const gsInvoice = 'http://192.168.1.15:30822';

  static const gsTransaction = 'https://dev-gs.zto.mn/tra';
  // static const gsTransaction = 'http://192.168.1.15:30827';

  static const gsScore = 'https://dev-gs.zto.mn/sco';

  static const version = '/api';

  Dio dio = Dio();

  Future<dynamic> request(String api, String method, dynamic data, String? type,
      {bool handler = true, bool approve = false}) async {
    Response? response;
    final String uri;

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
      // try {
      //   result = await _connectivity.checkConnectivity();
      //   if (result == ConnectivityResult.none) {
      //     MyApp.dialogService!
      //         .showInternetErrorDialog("No internet connection");
      //     return null;
      //   }
      // } on PlatformException catch (e) {
      //   debugPrint(e.toString());
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
