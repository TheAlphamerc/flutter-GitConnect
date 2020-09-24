import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/User_repository.dart';
import 'package:flutter_github_connect/resources/repository/people_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PeopleEvent extends Equatable {
  final PeopleRepository _peopleRepository = PeopleRepository(apiGatway: GetIt.instance<ApiGateway>());

  final UserRepository _userRepository = UserRepository(apiGatway: GetIt.instance<ApiGateway>());

  @override
  List<Object> get props => [];

  Stream<PeopleState> fetchFollowersList({PeopleState currentState, PeopleBloc bloc}) async* {}

  Stream<PeopleState> getUser({PeopleState currentState, PeopleBloc bloc}) async* {}

  Stream<PeopleState> getActivities({PeopleState currentState, PeopleBloc bloc}) async* {}
  
  Stream<PeopleState> getRepoWatchers({PeopleState currentState, PeopleBloc bloc})  async* {}
  
  Stream<PeopleState> getNextRepoWatchers({PeopleState currentState, PeopleBloc bloc}) async* {}

  Stream<PeopleState> getRepoStargezres({PeopleState currentState, PeopleBloc bloc})  async* {}
  
  Stream<PeopleState> getNextRepoStargezres({PeopleState currentState, PeopleBloc bloc}) async* {}
}

class LoadUserEvent extends PeopleEvent {
  LoadUserEvent({this.login, this.isLoadNextRepositories = false});

  final bool isLoadNextRepositories;
  final String login;

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
      yield LoadedUserState.next(
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
}

class LoadFollowEvent extends PeopleEvent {
  LoadFollowEvent(this.login, this.type, {this.isLoadNextFollow = false});

  final bool isLoadNextFollow;
  final String login;
  final PeopleType type;

  @override
  Stream<PeopleState> fetchFollowersList(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    try {
      if (!isLoadNextFollow) {
        yield LoadingFollowState();
        final followers =
            await _peopleRepository.fetchFollowersList(login, type: type);
        yield LoadedFollowState(followers);
      } else {
        final state = currentState as LoadedFollowState;
        if (!state.followModel.pageInfo.hasNextPage) {
          print("No ${type.asString()} list left");
          return;
        }
        yield LoadingNextFollowState(state.followModel);
        final followModel = await _peopleRepository.fetchFollowersList(login,
            type: type, endCursor: state.followModel.pageInfo.endCursor);
        yield LoadedFollowState.next(
            model: followModel, currentFollowModel: state.followModel);
      }
    } on OperationException catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadFollowEvent', error: _, stackTrace: stackTrace);
      yield ErrorPeopleState("Please check your internet connection");
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadFollowEvent', error: _, stackTrace: stackTrace);
      yield ErrorPeopleState(_?.toString());
    }
  }
}


class LoadPeopleActivitiesEvent extends PeopleEvent {
  final bool loadNextActivity;

  LoadPeopleActivitiesEvent({this.loadNextActivity=false});
  @override
  Stream<PeopleState> getActivities(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    try {
      final state = currentState as LoadedUserState;
      yield LoadingPeopleActivityStates(user: state.user);

      final list = await _userRepository.fetchUserEvent(
          login: state.user.login, pageNo: 1);
      final bool hasNextPage = list.length == 20;
      yield LoadedPeopleActivityStates(list,
          user: state.user, pageNo: 2, hasNextPage: hasNextPage);
    } catch (_, stackTrace) {
      developer.log('$_',name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      yield ErrorPeopleState(_?.toString());
    }
  }

  Stream<PeopleState> getNextActivities(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    final state = currentState as LoadedPeopleActivityStates;
    try {
      if (!state.hasNextPage) {
        print("No activities left");
        return;
      }
      yield LoadingNextPeopleActivityStates(user: state.user,eventList:state.eventList);

      final list = await _userRepository.fetchUserEvent(
          login: state.user.login, pageNo: state.pageNo);
      yield LoadedPeopleActivityStates.next(
          currentList: state.eventList,
          eventList: list,
          user: state.user,
          pageNo: state.pageNo + 1);
    } catch (_, stackTrace) {
      developer.log('$_',name: 'People_event', error: _, stackTrace: stackTrace);
      yield ErrorActivitiesState(_?.toString(), state.user);
    }
  }
}

class LoadWatchersEvent extends PeopleEvent {
  final bool isLoadNextWatchers;
  final String name;
  final String owner;
  LoadWatchersEvent({this.isLoadNextWatchers=false,this.name,this.owner}) : assert(name != null), assert(owner!= null);
  @override
  Stream<PeopleState> getRepoWatchers(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    try {
      yield LoadingWatcherState();

      final list = await _peopleRepository.getRepoWatchers(name: name, owner: owner);
      yield LoadedWatcherState(list);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadWatchersEvent', error: _, stackTrace: stackTrace);
      yield ErrorWatchersState(_?.toString());
    }
  }
  @override
  Stream<PeopleState> getNextRepoWatchers(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    final state = currentState as LoadedWatcherState;
    try {
      if (!state.watchers.pageInfo.hasNextPage) {
        print("No watchers left");
        return;
      }
      yield LoadingNextWatcherState(state.watchers);

     final list = await _peopleRepository.getRepoWatchers(name: name, owner: owner,endCursor:state.watchers.pageInfo.endCursor);
      yield LoadedWatcherState.next(currentWatchers: state.watchers, watchers:list);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'People_event', error: _, stackTrace: stackTrace);
      yield ErrorNextWatchersState(_?.toString(), watchers: state.watchers);
    }
  }
}

class LoadStargezersEvent extends PeopleEvent {
  final bool isLoadNextStartgers;
  final String name;
  final String owner;
  LoadStargezersEvent({this.isLoadNextStartgers=false,this.name,this.owner}) : assert(name != null), assert(owner!= null);
  @override
  Stream<PeopleState> getRepoStargezres(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    try {
      yield LoadingStargezersState();

      final list = await _peopleRepository.fetchRepoStargazers(name: name, owner: owner);
      yield LoadedStargezersState(list);
    } catch (_, stackTrace) {
      developer.log('$_',name: 'LoadStargezersEvent', error: _, stackTrace: stackTrace);
      yield ErrorStargezersState(_?.toString());
    }
  }
  @override
  Stream<PeopleState> getNextRepoStargezres(
      {PeopleState currentState, PeopleBloc bloc}) async* {
    final state = currentState as LoadedStargezersState;
    try {
      if (!state.stargezers.pageInfo.hasNextPage) {
        print("No watchers left");
        return;
      }
      yield LoadingNextStargezersState(state.stargezers);

     final list = await _peopleRepository.fetchRepoStargazers(name: name, owner: owner,endCursor:state.stargezers.pageInfo.endCursor);
      yield LoadedStargezersState.next(currentStargazers: state.stargezers, stargezers:list);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'People_event', error: _, stackTrace: stackTrace);
      yield ErrorNextStargezersState(_?.toString(), stargezers: state.stargezers);
    }
  }
}