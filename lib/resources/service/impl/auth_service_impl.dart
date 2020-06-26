import 'package:dio/dio.dart';
import 'package:flutter_github_connect/exceptions/exceptions.dart';
import 'package:flutter_github_connect/helper/config.dart';
import 'package:flutter_github_connect/resources/service/auth_service.dart';

import '../../dio_client.dart';

class AuthServiceImpl implements AuthService {
  final DioClient _dioClient;

  AuthServiceImpl(this._dioClient);
  @override
  Future<String> getAcessToken(String code) async{
     try {
      var response = await _dioClient.post( null, completeUrl:Config.accessTken+code);
      bool isSuccess = _isSuccessOrThrow(response);
      if (isSuccess) {
        return response.data as String;
      } else {
        return null;
      }
    } catch (error) {
      throw error;
    }
  }

  bool _isSuccessOrThrow(Response response) {
    print("ApiGateway isSuccess");
    switch (response.statusCode) {
      case 200:
        return true;
      case 201:
        return true;
      case 400:
        throw BadRequestException("Bad request");
      case 401:
      case 403:
        throw UnauthorisedException("Session expired");
      case 404:
        throw ResourceNotFoundException(response.statusMessage.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communicating with server : ${response.statusCode}');
    }
  }
}
