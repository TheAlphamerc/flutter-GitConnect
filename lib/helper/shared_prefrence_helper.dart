import 'dart:convert';

import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceHelper {
  SharedPrefrenceHelper._internal();
  static final SharedPrefrenceHelper _singleton =
      SharedPrefrenceHelper._internal();

  factory SharedPrefrenceHelper() {
    return _singleton;
  }
  Future<bool> setAccessToken(String value) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.AccesssToken.toString(), value);
  }

  Future<String> getAccessToken() async {
    return (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.AccesssToken.toString());
  }

  Future<String> getCountryIsoCode() async {
    return (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.CountryISOCode.toString());
  }

  Future<bool> setCountryIsoCode(String value) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.CountryISOCode.toString(), value);
  }

  Future<String> getLanguageCode() async {
    return (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.LanguageCode.toString());
  }

  Future<bool> setLanguageCode(String value) async {
    return (await SharedPreferences.getInstance())
        .setString(UserPreferenceKey.LanguageCode.toString(), value);
  }
  Future<Null> cleaPrefrenceValues()async{
    await (SharedPreferences.getInstance())..clear();
  }
  Future<void> saveUserProfile(UserModel user) async {
   return (await SharedPreferences.getInstance())
         .setString(UserPreferenceKey.UserProfile.toString(), user.toJson().toString());
  }

  Future<UserModel> getUserProfile() async {
    final jsonString = (await SharedPreferences.getInstance())
        .getString(UserPreferenceKey.UserProfile.toString());
    return UserModel.fromJson(json.decode(jsonString));
  }
}

enum UserPreferenceKey {
  LanguageCode,
  CountryISOCode,
  AccesssToken,
  UserProfile
}
