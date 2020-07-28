import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/auth/index.dart';
import 'package:flutter_github_connect/resources/repository/auth_repository.dart';
import 'package:flutter_github_connect/resources/service/auth_service.dart';
import 'package:flutter_github_connect/resources/service/session_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
  Stream<AuthState> getAcessToken({AuthState currentState, AuthBloc bloc});

  final AuthRepository _authRepository = AuthRepository(
      authService: GetIt.instance<AuthService>(),
      sessionService: GetIt.instance<SessionService>());
}
class LoadingWebView extends AuthEvent {
  @override
  Stream<AuthState> getAcessToken({AuthState currentState, AuthBloc bloc}) {
    throw UnimplementedError();
  }
}
class LoadAuthEvent extends AuthEvent {
  final String code;
  @override
  String toString() => 'LoadAuthEvent';

  LoadAuthEvent(this.code);

  @override
  Stream<AuthState> getAcessToken(
      {AuthState currentState, AuthBloc bloc}) async* {
    try {
     
      yield LoadingAuthState();
      await Future.delayed(Duration(seconds: 1));
      final isSuscess = await _authRepository.getAcessToken(code);
      yield SucessState(isSuscess);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadAuthEvent', error: _, stackTrace: stackTrace);
      yield ErrorAuthState(_?.toString());
    }
  }
}
