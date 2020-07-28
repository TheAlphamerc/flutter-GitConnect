import 'package:dio/dio.dart';
import 'package:flutter_github_connect/exceptions/exceptions.dart';
import 'package:flutter_github_connect/helper/config.dart';
import 'package:flutter_github_connect/resources/graphql_client.dart';
import 'package:flutter_github_connect/resources/service/auth_service.dart';
import 'package:flutter_github_connect/resources/service/session_service.dart';

import '../../dio_client.dart';

class AuthServiceImpl implements AuthService {
  final DioClient _dioClient;
  final SessionService _sessionService;
  AuthServiceImpl(this._dioClient, this._sessionService);
  @override
  Future<String> getAcessToken(String code) async{
     try {
      var response = await _dioClient.post( null, completeUrl:Config.accessTken+code);
      
        return response.data as String;
      
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> getUserName(String code) async{
   
    try {
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      final result = await getAuthUserName();
      if (result.hasException) {
        print(result.exception.toString());
        throw result.exception;
      }

      final map = result.data['viewer'] as Map<String, dynamic>;
      final userName = map["login"] as String;

      return userName;
    } catch (error) {
      throw error;
    }
  }
}
