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
class LoadingEventState extends LoadedUserState {
  LoadingEventState(UserModel user, List<EventModel> eventList) : super(user, eventList);
  
}

/// Initialized
class LoadedUserState extends UserState {
  final UserModel user;
  final List<EventModel> eventList;
  LoadedUserState(this.user, this.eventList);

  factory LoadedUserState.getNextRepositories(
      {UserModel userModel, UserModel currentUserModel,List<EventModel> eventList}) {
    currentUserModel.repositories.nodes.addAll(userModel.repositories.nodes);
    currentUserModel.repositories.pageInfo = userModel.repositories.pageInfo;
    return LoadedUserState(currentUserModel,eventList);
  }

  @override
  String toString() => 'LoadedUserState $user';
}

class LoadingNextRepositoriesState extends LoadedUserState {
  final UserModel user;
  LoadingNextRepositoriesState(this.user,{List<EventModel> eventList}) : super(user,eventList);
}

class LoadedPullRequestState extends LoadedUserState {
  final UserModel user;
  final List<EventModel> eventList;
  final UserPullRequests pullRequestsList;

  LoadedPullRequestState(
      {@required this.user, this.eventList, this.pullRequestsList}): super(user,eventList);

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
  ErrorNextRepositoryState({UserModel user, this.errorMessage,List<EventModel> eventList}) : super(user,eventList);

  @override
  String toString() => 'ErrorUserState';
}

class ErrorPullRequestState extends LoadedUserState {
  final String errorMessage;
  final UserModel user;
  final List<EventModel> eventList;
  ErrorPullRequestState(this.errorMessage, {this.user, this.eventList})
      : super( user,eventList);

  @override
  String toString() => 'ErrorUserState';
}