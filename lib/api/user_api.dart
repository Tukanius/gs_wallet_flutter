import 'package:dio/dio.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/models/user.dart';
import 'package:green_score/models/notify.dart';
import 'package:green_score/utils/http_request.dart';

class UserApi extends HttpRequest {
  avatar(User data) async {
    var res = await post('/user/avatar', "USER", data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  editProfile(User data, String id) async {
    var res = await put('/user/$id', "USER", data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  upload(String path) async {
    String fileName = path.split('/').last;
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(path, filename: fileName),
    });
    var res = await post('/image/avatar', "MEDIA", data: formData);

    return User.fromJson(res as Map<String, dynamic>);
  }

  danVerify() async {
    var res = await post('/user/verify', "USER", handler: true);
    return res;
  }

  getNotification(ResultArguments resultArguments) async {
    var res = await get('/notification', "USER",
        handler: true, data: resultArguments.toJson());
    return Result.fromJson(res, Notify.fromJson);
  }

  getNotCount() async {
    var res = await get('/notification/count', "USER", handler: false);
    return res;
  }

  seenNot(String id) async {
    var res = await put('/notification/$id', "USER", handler: false);
    return res;
  }
}
