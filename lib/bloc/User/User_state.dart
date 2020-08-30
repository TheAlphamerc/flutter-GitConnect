import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/model/pul_request.dart';

abstract class UserState extends Equatable {
  UserState();

  @override
  List<Object> get props => ([]);
}

class LoadingUserState extends UserState {}

/// Initialized
class LoadedUserState extends UserState {
  final UserModel user;

  LoadedUserState(this.user);

  factory LoadedUserState.getNextRepositories(
      {UserModel userModel, UserModel currentUserModel}) {
    currentUserModel.repositories.nodes.addAll(userModel.repositories.nodes);
    currentUserModel.repositories.pageInfo = userModel.repositories.pageInfo;
    return LoadedUserState(currentUserModel);
  }

  @override
  String toString() => 'LoadedUserState $user';
}

class LoadingNextRepositoriesState extends LoadedUserState {
  final UserModel user;
  LoadingNextRepositoriesState(this.user) : super(user);
}

class LoadedEventsState extends LoadedUserState {
  final UserModel user;
  final List<EventModel> eventList;

  LoadedEventsState({@required this.user, this.eventList}) : super(user);

  @override
  String toString() => 'LoadedUserState $user';
}

class LoadedPullRequestState extends LoadedEventsState {
  final UserModel user;
  final List<EventModel> eventList;
  final UserPullRequests pullRequestsList;

  LoadedPullRequestState(
      {@required this.user, this.eventList, this.pullRequestsList})
      : super(user: user, eventList: eventList);

  @override
  String toString() => 'LoadedUserState $user';
}

class LoadedGitState extends LoadedEventsState {
  final UserModel user;
  final List<EventModel> eventList;
  final Gists gist;

  LoadedGitState({@required this.user, this.eventList, this.gist})
      : super(user: user, eventList: eventList);

  @override
  String toString() => 'LoadedUserState $user';
}

class ErrorUserState extends UserState {
  final String errorMessage;

  ErrorUserState(this.errorMessage);

  @override
  String toString() => 'ErrorUserState';
}

class ErrorNextRepositoryState extends LoadedUserState {
  final String errorMessage;
  ErrorNextRepositoryState({UserModel user, this.errorMessage}) : super(user);

  @override
  String toString() => 'ErrorUserState';
}

class ErrorPullRequestState extends LoadedEventsState {
  final String errorMessage;
  final UserModel user;
  final List<EventModel> eventList;
  ErrorPullRequestState(this.errorMessage, {this.user, this.eventList})
      : super(user: user, eventList: eventList);

  @override
  String toString() => 'ErrorUserState';
}

class ErrorGitState extends LoadedEventsState {
  final String errorMessage;
  final UserModel user;
  final List<EventModel> eventList;
  ErrorGitState(this.errorMessage, {this.user, this.eventList})
      : super(user: user, eventList: eventList);

  @override
  String toString() => 'ErrorUserState';
}
