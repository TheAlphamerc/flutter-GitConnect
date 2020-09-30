import 'package:dio/dio.dart';
import 'package:flutter_github_connect/helper/config.dart';
import 'package:flutter_github_connect/helper/shared_prefrence_helper.dart';
import 'package:flutter_github_connect/resources/dio_client.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway_impl.dart';
import 'package:flutter_github_connect/resources/service/auth_service.dart';
import 'package:flutter_github_connect/resources/service/db_service/db_service.dart';
import 'package:flutter_github_connect/resources/service/db_service/db_service_impl.dart';
import 'package:flutter_github_connect/resources/service/impl/auth_service_impl.dart';
import 'package:flutter_github_connect/resources/service/impl/session_service_impl.dart';
import 'package:flutter_github_connect/resources/service/session_service.dart';
import 'package:get_it/get_it.dart';

void setUpDependency() {
  final serviceLocator = GetIt.instance;

  serviceLocator
      .registerSingleton<SharedPrefrenceHelper>(SharedPrefrenceHelper());

  serviceLocator.registerLazySingleton<SessionService>(
    () => SessionServiceImpl(
      GetIt.instance<SharedPrefrenceHelper>(),
    ),
  );
  serviceLocator.registerLazySingleton<AuthService>(
    () => AuthServiceImpl(
      DioClient(Dio(), baseEndpoint: Config.apiBaseUrl, logging: true),
      GetIt.instance<SessionService>(),
    ),
  );
  serviceLocator.registerLazySingleton<ApiGateway>(
    () => ApiGatwayImpl(
      DioClient(Dio(), baseEndpoint: Config.apiBaseUrl, logging: true),
      GetIt.instance<SessionService>(),
    ),
  );

  serviceLocator.registerSingletonAsync<DbService>(
     ()async  => DbServiceImpl().initDB()
  );
}
