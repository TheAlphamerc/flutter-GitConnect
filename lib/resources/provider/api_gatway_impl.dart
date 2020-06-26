import 'package:dio/dio.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/exceptions/exceptions.dart';
import 'package:flutter_github_connect/helper/config.dart';
import 'package:flutter_github_connect/resources/dio_client.dart';
import 'package:flutter_github_connect/resources/provider/api_gatway.dart';
import 'package:flutter_github_connect/resources/service/session_servoce.dart';

class ApiGatwayImpl implements ApiGateway {
  final DioClient _dioClient;
  final SessionService _sessionService;
  ApiGatwayImpl(this._dioClient, this._sessionService);

  @override
  Future<UserModel> fetchUserProfile() async {
    try {
      var accesstoken = await _sessionService.loadSession();
      var response = await _dioClient.get(
        Config.user,
        options: Options(
          headers: {'Authorization': 'token $accesstoken'},
        ),
      );
      bool isSuccess = _isSuccessOrThrow(response);
      if (isSuccess) {
        return UserModel.fromJson(_dioClient.getJsonBody(response));
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
