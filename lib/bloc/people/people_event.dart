import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/User_repository.dart';
import 'package:flutter_github_connect/resources/repository/people_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PeopleEvent extends Equatable {
  @override
  List<Object> get props => [];
  Stream<PeopleState> fetchFollowersList(
      {PeopleState currentState, PeopleBloc bloc});
  Stream<PeopleState> getUser({PeopleState currentState, PeopleBloc bloc});

  Stream<PeopleState> getGist(
      {PeopleState currentState, PeopleBloc bloc}) async* {}
  Stream<PeopleState> getPullRequest(
      {PeopleState currentState, PeopleBloc bloc});

  final PeopleRepository _peopleRepository =
      PeopleRepository(apiGatway: GetIt.instance<ApiGateway>());
  final UserRepository _userRepository =
      UserRepository(apiGatway: GetIt.instance<ApiGateway>());
}

class LoadUserEvent extends PeopleEvent {
  final String login;

  LoadUserEvent({this.login});
  @override
  Stream<PeopleState> getUser(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    try {
      if (currentState is LoadedUserState) {
        return;
      }
      // yield LoadingUserState();
      final userModel = await _userRepository.fetchUserProfile(login: login);
      yield LoadedUserState(user: userModel);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      yield ErrorPeopleState(_?.toString());
    }
  }

  @override
  Stream<PeopleState> fetchFollowersList(
      {PeopleState currentState, PeopleBloc bloc}) {
    return null;
  }

  @override
  Stream<PeopleState> getPullRequest(
      {PeopleState currentState, PeopleBloc bloc}) {
    return null;
  }
}

class LoadFollowerEvent extends PeopleEvent {
  final String login;
  final PeopleType type;

  LoadFollowerEvent(this.login, this.type);
  @override
  Stream<PeopleState> fetchFollowersList(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    try {
      yield LoadingFollowersState();
      switch (type) {
        case PeopleType.Follower:
          final followers = await _peopleRepository.fetchFollowersList(login);
          yield LoadedFollowersState(followers);
          break;
        case PeopleType.Following:
          final following = await _peopleRepository.fetchFollowingList(login);
          yield LoadedFollowingState(following);
          break;
        default:
          ErrorPeopleState("Unknown People type");
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadPeopleEvent', error: _, stackTrace: stackTrace);
      yield ErrorPeopleState(_?.toString());
    }
  }

  @override
  Stream<PeopleState> getUser({PeopleState currentState, PeopleBloc bloc}) {
    return null;
  }

  @override
  Stream<PeopleState> getPullRequest(
      {PeopleState currentState, PeopleBloc bloc}) {
    return null;
  }
}

class OnPullRequestLoad extends PeopleEvent {
  final String login;

  OnPullRequestLoad(this.login);
  @override
  Stream<PeopleState> getGist(
      {PeopleState currentState, PeopleBloc bloc}) async* {}

  @override
  Stream<PeopleState> getPullRequest(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    if (currentState is LoadedPullRequestState) {
      return;
    }
    // final state = currentState as LoadedEventsState;
    try {
      yield LoadingPullRequestState();
      print("Loading PeopleState");
      final pullRequestsList = await _userRepository.fetchPullRequest(login:login);
      print("Loading End");
      yield LoadedPullRequestState(pullRequestsList: pullRequestsList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      yield ErrorPullRequestState(
        _?.toString(),
      );
    }
  }

  @override
  Stream<PeopleState> fetchFollowersList(
      {PeopleState currentState, PeopleBloc bloc}) {
    return null;
  }

  @override
  Stream<PeopleState> getUser({PeopleState currentState, PeopleBloc bloc}) {
    return null;
  }
}

class OnGistLoad extends PeopleEvent {
  final String login;

  OnGistLoad(this.login);

  @override
  Stream<PeopleState> getGist(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    if (currentState is LoadedGitState) {
      return;
    }
    try {
      // yield LoadingUserState();
      print("Loading Gist state");
      final pullRequestsList =
          await _userRepository.fetchGistList(login: login);
      print("Loading End");
      yield LoadedGitState(gist: pullRequestsList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      yield ErrorGitState(_?.toString());
    }
  }

  @override
  Stream<PeopleState> getUser(
      {PeopleState currentState, PeopleBloc bloc}) async* {}

  @override
  Stream<PeopleState> getPullRequest(
      {PeopleState currentState, PeopleBloc bloc}) async* {}
  @override
  Stream<PeopleState> fetchFollowersList(
      {PeopleState currentState, PeopleBloc bloc}) {
    return null;
  }
}
