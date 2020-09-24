import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/User/index.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/User_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
  
  final UserRepository _userRepository =UserRepository(apiGatway: GetIt.instance<ApiGateway>());
  
  Stream<UserState> getUser({UserState currentState, UserBloc bloc})async*{}
  
  Stream<UserState> getGist({UserState currentState, UserBloc bloc})async*{}
  
}

class OnLoad extends UserEvent {
  final bool isLoadNextRepositories;

  OnLoad({this.isLoadNextRepositories = false});

  @override
  Stream<UserState> getUser({UserState currentState, UserBloc bloc}) async* {
    try {
      if (currentState is LoadedUserState) {
        return;
      }
      yield LoadingUserState();
      final userModel = await _userRepository.fetchUserProfile();
      yield LoadedUserState(userModel,null);
      yield LoadingEventState(userModel,null);
      final eventList = await _userRepository.fetchUserEvent();
      yield LoadedUserState(userModel, eventList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      yield ErrorUserState(_?.toString());
    }
  }


  Stream<UserState> getNextRepositories(
      {UserState currentState, UserBloc bloc}) async* {
    try {
      final state = currentState as LoadedUserState;
      if (!state.user.repositories.pageInfo.hasNextPage) {
        print("No repository left");
        return;
      }
      yield LoadingNextRepositoriesState(state.user);
      final userModel = await _userRepository.fetchNextRepositorries(
          login: state.user.login,
          endCursor: state.user.repositories.pageInfo.endCursor);
      yield LoadedUserState.getNextRepositories(
          currentUserModel: state.user, userModel: userModel, eventList: state.eventList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedUserState;
      yield ErrorNextRepositoryState(
          errorMessage: _?.toString(), user: state.user);
    }
  }
}