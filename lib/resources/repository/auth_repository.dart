import 'package:flutter/material.dart';
import 'package:flutter_github_connect/resources/service/auth_service.dart';
import 'package:flutter_github_connect/resources/service/session_servoce.dart';

class AuthRepository {
  final AuthService authService;
  final SessionService sessionService;

  AuthRepository({this.sessionService, @required this.authService}) : assert(authService != null, sessionService != null);

  Future<bool> getAcessToken(String code) async{
    final token  = await authService.getAcessToken(code);
    if(token != null){
       await sessionService.saveSession(token);
      return true;
    }
    return false;
  }
}
