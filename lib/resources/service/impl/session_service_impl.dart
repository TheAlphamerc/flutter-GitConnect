import 'dart:developer';

import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/resources/service/session_servoce.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionServiceImpl implements SessionService {
  @override
  Future<void> saveSession(String acessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('acessToken', acessToken);
    log("Session Saved !!", name:"Session Service");
  }

  @override
  Future<String> loadSession()async {
    final prefs = await SharedPreferences.getInstance();
    log("Load Session!!", name:"Session Service");
    return  prefs.getString('acessToken');
  }

  @override
  Future<void> refreshSession() {
    throw UnimplementedError();
  }

  @override
  Future<T> refreshSessionOnUnauthorized<T>(
      Future<T> Function() handler) async {
    try {
      return await handler();
    } on Exception catch (_) {
      await refreshSession();
      return await handler();
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user.toJson().toString());
    log("User Saved !!", name:"Session Service");
  }

  @override
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
