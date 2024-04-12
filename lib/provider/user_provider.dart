// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:green_score/api/auth_api.dart';
import 'package:green_score/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User user = User();

  me(bool handler) async {
    user = await AuthApi().me(handler);
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

  // me() async {
  //   user = await AuthApi().me();
  //   notifyListeners();
  // }
  register(User data) async {
    user = await AuthApi().register(data);
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
}
