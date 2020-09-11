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
  final bool isLoadNextRepositories;

  LoadUserEvent({this.login, this.isLoadNextRepositories = false});
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

  Stream<PeopleState> getNextRepositories(
      {PeopleState currentState, PeopleBloc bloc}) async* {
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
        currentUserModel: state.user,
        userModel: userModel,
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedUserState;
      yield ErrorNextRepositoryState(
          errorMessage: _?.toString(), user: state.user);
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
          name: 'LoadFollowerEvent', error: _, stackTrace: stackTrace);
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
  final bool isLoadNextIssues;

  OnPullRequestLoad(this.login, {this.isLoadNextIssues = false});
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
      final pullRequestsList =
          await _userRepository.fetchPullRequest(login: login);
      yield LoadedPullRequestState(pullRequestsList: pullRequestsList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'OnPullRequestLoad', error: _, stackTrace: stackTrace);
      yield ErrorPullRequestState(
        _?.toString(),
      );
    }
  }

  Stream<PeopleState> getNextPullRequest(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    try {
      final state = currentState as LoadedPullRequestState;
      if (!state.pullRequestsList.pageInfo.hasNextPage) {
        print("No pull request left");
        return;
      }
      yield LoadingNextPullRequestState(
          state.user, state.eventList, state.pullRequestsList);
      final newPullRequestList = await _userRepository.fetchPullRequest(
          login: login, endCursor: state.pullRequestsList.pageInfo.endCursor);
      yield LoadedPullRequestState.getNextRepositories(
          currentpullRequestsList: state.pullRequestsList,
          userModel: state.user,
          eventList: state.eventList,
          pullRequestsList: newPullRequestList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'OnPullRequestLoad', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedPullRequestState;
      yield ErrorNextPullRequestState(
        errorMessage: _?.toString(),
        eventList: state.eventList,
        pullRequestsList: state.pullRequestsList,
        user: state.user,
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
  final bool isLoadNextGist;
  OnGistLoad(this.login, {this.isLoadNextGist = false});

  @override
  Stream<PeopleState> getGist(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    if (currentState is LoadedGitState) {
      return;
    }
    try {
      // yield LoadingUserState();

      final gistModel = await _userRepository.fetchGistList(login: login);

      yield LoadedGitState(gist: gistModel);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'OnGistLoad', error: _, stackTrace: stackTrace);
      yield ErrorGitState(_?.toString());
    }
  }

  Stream<PeopleState> getNextGist(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    try {
      final state = currentState as LoadedGitState;
      if (!state.gist.pageInfo.hasNextPage) {
        print("No Gist left");
        return;
      }
      yield LoadingNextGistState(
        gist: state.gist,
        user: state.user,
        eventList: state.eventList,
      );
      print(state.gist.pageInfo.endCursor);
      final gistModel = await _userRepository.fetchGistList(
          login: login, endCursor: state.gist.pageInfo.endCursor);
      yield LoadedGitState.next(
        currenctGistModel: state.gist,
        userModel: state.user,
        eventList: state.eventList,
        gistModel: gistModel,
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'OnGistLoadt', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedGitState;
      yield ErrorNextGistState(
        errorMessage: _?.toString(),
        eventList: state.eventList,
        gist: state.gist,
        user: state.user,
      );
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
