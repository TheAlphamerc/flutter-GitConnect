import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/resources/provider/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/User_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent extends Equatable {
   @override
  List<Object> get props => [];
  Stream<UserState> applyAsync(
      {UserState currentState, UserBloc bloc});
  final UserRepository _userRepository = UserRepository(apiGatway: GetIt.instance<ApiGateway>());
  
}

class UnUserEvent extends UserEvent {
  @override
  Stream<UserState> applyAsync({UserState currentState, UserBloc bloc}) async* {
    yield UnUserState(0);
  }
}

class LoadUserEvent extends UserEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadUserEvent';

  LoadUserEvent(this.isError);

  @override
  Stream<UserState> applyAsync(
      {UserState currentState, UserBloc bloc}) async* {
    try {
      yield UnUserState(0);
      await Future.delayed(Duration(seconds: 1));
      _userRepository.fetchUserProfile();
      yield InUserState(0, 'Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      yield ErrorUserState(0, _?.toString());
    }
  }
}
