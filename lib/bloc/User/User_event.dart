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
  Stream<UserState> getGist({UserState currentState, UserBloc bloc});
  Stream<UserState> getPullRequest({UserState currentState, UserBloc bloc});
  final UserRepository _userRepository =
      UserRepository(apiGatway: GetIt.instance<ApiGateway>());
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
          currentUserModel: state.user, userModel: userModel);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedUserState;
      yield ErrorNextRepositoryState(
          errorMessage: _?.toString(), user: state.user);
    }
  }

  @override
  Stream<UserState> getGist({UserState currentState, UserBloc bloc}) async* {}
}

class OnPullRequestLoad extends UserEvent {
  @override
  Stream<UserState> getGist({UserState currentState, UserBloc bloc}) async* {}

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

class OnGistLoad extends UserEvent {
  @override
  Stream<UserState> getUser({UserState currentState, UserBloc bloc}) async* {}

  @override
  Stream<UserState> getPullRequest(
      {UserState currentState, UserBloc bloc}) async* {}
  @override
  Stream<UserState> getGist({UserState currentState, UserBloc bloc}) async* {
    if (currentState is LoadedGitState) {
      return;
    }
    final state = currentState as LoadedEventsState;
    try {
      yield LoadingUserState();
      print("Loading Gist state");
      final pullRequestsList = await _userRepository.fetchGistList();
      print("Loading End");
      yield LoadedGitState(
          user: state.user, eventList: state.eventList, gist: pullRequestsList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      yield ErrorGitState(_?.toString(),
          user: state.user, eventList: state.eventList);
    }
  }
}
