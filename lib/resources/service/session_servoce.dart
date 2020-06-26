import 'package:flutter_github_connect/bloc/User/User_model.dart';

abstract class SessionService {
  Future<void> saveSession(String session);
  
  Future<void> saveUser(UserModel register);

  Future<String> loadSession();

  Future<void> refreshSession();

  Future<void> clearSession();

  Future<T> refreshSessionOnUnauthorized<T>(Future<T> Function() handler);
}