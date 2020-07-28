import 'package:flutter/material.dart';
import 'package:flutter_github_connect/resources/service/auth_service.dart';
import 'package:flutter_github_connect/resources/service/session_service.dart';

class AuthRepository {
  final AuthService authService;
  final SessionService sessionService;

  AuthRepository({this.sessionService, @required this.authService})
      : assert(authService != null, sessionService != null);

  Future<bool> getAcessToken(String code) async {
    String token = await authService.getAcessToken(code);
    if (token != null) {
      token = token.split("&scope")[0].split("=")[1];
      await sessionService.saveSession(token);
      String username = await authService.getUserName(code);
      sessionService.setUserName(username);
      return true;
    }
    return false;
  }
}
