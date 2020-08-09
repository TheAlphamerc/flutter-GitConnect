import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/people_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PeopleEvent  extends Equatable {
  @override
  List<Object> get props => [];
  Stream<PeopleState> fetchFollowersList(
      {PeopleState currentState, PeopleBloc bloc});
  final PeopleRepository _peopleRepository =
      PeopleRepository(apiGatway: GetIt.instance<ApiGateway>());
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
        default:ErrorPeopleState("Unknown People type");
      }
     
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadPeopleEvent', error: _, stackTrace: stackTrace);
      yield ErrorPeopleState(_?.toString());
    }
  }
}
