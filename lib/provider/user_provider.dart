import 'package:flutter/material.dart';
import 'package:green_score/api/auth_api.dart';
import 'package:green_score/api/user_api.dart';
import 'package:green_score/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User user = User();
  bool isView = false;

  me(bool handler) async {
    user = await AuthApi().me(handler);
    setAccessToken(user.accessToken);
    notifyListeners();
  }

  logout() async {
    user = User();
    clearAccessToken();
  }

  clearAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("ACCESS_TOKEN");
  }

  register(User data) async {
    data.email!.toLowerCase().trim();
    data.type = "USER";
    user = await AuthApi().register(data);
    setAccessToken(user.accessToken);
    return user;
  }

  editProfile(User data, String id) async {
    user = await UserApi().editProfile(data, id);
    setAccessToken(user.accessToken);
    return user;
  }

  login(User data) async {
    user = await AuthApi().login(data);
    setAccessToken(user.accessToken);
    notifyListeners();
  }

  setAccessToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) prefs.setString("ACCESS_TOKEN", token);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("ACCESS_TOKEN");
    return token;
  }

  setPassword(User data) async {
    user = await AuthApi().setPassword(data);
    setAccessToken(user.accessToken);
    return user;
  }

  forgetPass(User data) async {
    user = await AuthApi().forgetPass(data);
    setAccessToken(user.accessToken);
    return user;
  }

  getOtp(String otpMethod, String email) async {
    var res = await AuthApi().getPhoneOtp(otpMethod, email);
    return res;
  }

  otpVerify(User data) async {
    data = await AuthApi().otpVerify(data);
    await setAccessToken(data.accessToken);
    return data;
  }

  setView(value) {
    isView = value;
    notifyListeners();
  }
}
