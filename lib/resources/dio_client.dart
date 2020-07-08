import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_github_connect/exceptions/exceptions.dart';

class DioClient {
  final Dio _dio;
  final String baseEndpoint;
  final bool logging;

  DioClient(
    this._dio, {
    this.baseEndpoint,
    this.logging = false,
  })  : assert(baseEndpoint != null),
        assert(logging != null) {
    if (logging) {
      _dio.interceptors.add(
        LogInterceptor(
          requestHeader: true,
          responseHeader: true,
          requestBody: true,
          responseBody: true,
        ),
      );
    }
  }

  Future<Response<T>> get<T>(
    String endpoint, {
    String completeUrl,
    Options options,
    queryParameters,
  }) async {
    try {
      var isconnected = await hasInternetConnection();
      if (!isconnected) {
        throw SocketException("Please check your internet connection");
      }
      return await _dio.get(
        completeUrl != null ? completeUrl : '$baseEndpoint$endpoint',
        options: options,
        queryParameters: queryParameters,
      );
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response<T>> post<T>(
    String endpoint, {
    data,
    String completeUrl,
    Options options,
  }) async {
    try {
      return await _dio.post(
        completeUrl != null ? completeUrl : '$baseEndpoint$endpoint',
        data: data,
      );
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Map<String, dynamic> getJsonBody<T>(Response<T> response) {
    try {
      return response.data as Map<String, dynamic>;
    } on Exception catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw Exception('Bad body format');
    }
  }

  List<dynamic> getJsonBodyList<T>(Response<T> response) {
    try {
      return response.data as List<dynamic>;
    } on Exception catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw SchemeConsistencyException('Bad body format');
    }
  }

  Exception _handleError(DioError e) {
    switch (e.response.statusCode) {
      case 404:
        return ApiDataNotFoundException();
      case 500:
        return ApiInternalServerException();
      case 400:
        throw BadRequestException("Bad request  : ${e.response.statusCode}");
      case 401:
      case 403:
        throw UnauthorisedException(
            "Unauthorised request  : ${e.response.statusCode}");
      case 404:
        throw ResourceNotFoundException(
            "Resource not found  : ${e.response.statusCode}");
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communicating with server : ${e.response.statusCode}');
    }
  }

  Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
