import 'package:green_score/utils/http_request.dart';

import '../models/user.dart';

class AuthApi extends HttpRequest {
  login(User user) async {
    var res =
        await post('/auth/login', "AUTH", data: user.toJson(), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  me(bool handler) async {
    var res = await get('/auth/me', "USER", handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  setPassword(User user) async {
    var res = await post('/auth/change-password', "AUTH",
        data: user.toJson(), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  forgetPass(User user) async {
    var res =
        await post('/auth/forgot', "AUTH", data: user.toJson(), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  register(User user) async {
    var res = await post("/auth/register", "AUTH",
        data: user.toJson(), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  getPhoneOtp(String otpMethod, String email) async {
    var res = await get(
      "/otp?otpMethod=$otpMethod&username=$email",
      "AUTH",
    );
    return User.fromJson(res as Map<String, dynamic>);
  }

  otpVerify(User data) async {
    Map<String, dynamic> json = {};
    json['otpCode'] = data.otpCode;
    json['otpMethod'] = data.otpMethod;
    var res = await post('/otp/verify', "AUTH", data: json, handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }
}
