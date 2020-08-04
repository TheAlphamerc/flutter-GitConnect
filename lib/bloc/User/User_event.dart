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
  Stream<UserState> getUser({UserState currentState, UserBloc bloc});
  Stream<UserState> getPullRequest({UserState currentState, UserBloc bloc});
  final UserRepository _userRepository =
      UserRepository(apiGatway: GetIt.instance<ApiGateway>());
}

class OnLoad extends UserEvent {
  @override
  Stream<UserState> getUser({UserState currentState, UserBloc bloc}) async* {
    try {
      if (currentState is LoadedUserState) {
        return;
      }
      yield LoadingUserState();
      final userModel = await _userRepository.fetchUserProfile();
      yield LoadedUserState(userModel);

      final eventList = await _userRepository.fetchUserEvent();
      yield LoadedEventsState(user: userModel, eventList: eventList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      yield ErrorUserState(_?.toString());
    }
  }

  @override
  Stream<LoadedPullRequestState> getPullRequest(
      {UserState currentState, UserBloc bloc}) {
    return null;
  }
}

class OnPullRequestLoad extends UserEvent {
  @override
  Stream<UserState> getUser({UserState currentState, UserBloc bloc}) async* {}

  @override
  Stream<UserState> getPullRequest(
      {UserState currentState, UserBloc bloc}) async* {
    if (currentState is LoadedPullRequestState) {
      return;
    }
    final state = currentState as LoadedEventsState;
    try {
      yield LoadingUserState();
      // final userModel = await _userRepository.fetchUserProfile();
      // yield LoadedUserState(userModel);
      print("Loading UserState");
      final pullRequestsList = await _userRepository.fetchPullRequest();
      print("Loading End");
      yield LoadedPullRequestState(
          user: state.user,
          eventList: state.eventList,
          pullRequestsList: pullRequestsList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      yield ErrorPullRequestState(_?.toString(),
          user: state.user, eventList: state.eventList);
    }
  }
}
