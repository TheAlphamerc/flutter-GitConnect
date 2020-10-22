import 'package:dio/dio.dart';
import 'helper/config.dart';
import 'helper/shared_prefrence_helper.dart';
import 'resources/dio_client.dart';
import 'resources/gatway/gatway.dart';
import 'resources/service/service.dart';
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

  serviceLocator
      .registerSingletonAsync<DbService>(() async => DbServiceImpl().initDB());
}
