import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/bloc/people/people_model.dart' as people;
import 'package:flutter_github_connect/model/pul_request.dart';

abstract class PeopleState extends Equatable {
  @override
  List<Object> get props => ([]);
}

class LoadedUserState extends PeopleState {
  final UserModel user;

  LoadedUserState({@required this.user});

  @override
  String toString() => 'LoadedUserState $user';

  factory LoadedUserState.getNextRepositories(
      {UserModel userModel, UserModel currentUserModel}) {
    currentUserModel.repositories.nodes.addAll(userModel.repositories.nodes);
    currentUserModel.repositories.pageInfo = userModel.repositories.pageInfo;
    return LoadedUserState(user: currentUserModel);
  }
}

class LoadingNextRepositoriesState extends LoadedUserState {
  final UserModel user;
  LoadingNextRepositoriesState(
    this.user,
  ) : super(user: user);
}

class LoadingFollowersState extends PeopleState {}

class LoadingPullRequestState extends PeopleState {}

class LoadingFollowingState extends PeopleState {}

class LoadedFollowersState extends PeopleState {
  final people.Followers followers;

  LoadedFollowersState(this.followers);
}

class LoadedFollowingState extends PeopleState {
  final people.Following following;

  LoadedFollowingState(this.following);
}

class ErrorPeopleState extends PeopleState {
  final String errorMessage;

  ErrorPeopleState(this.errorMessage);

  @override
  String toString() => 'ErrorPeopleState';
}

class LoadedEventsState extends LoadedUserState {
  final UserModel user;
  final List<EventModel> eventList;

  LoadedEventsState({@required this.user, this.eventList}) : super(user: user);

  @override
  String toString() => 'LoadedUserState $user';
}

class LoadedPullRequestState extends LoadedEventsState {
  final UserModel user;
  final List<EventModel> eventList;
  final UserPullRequests pullRequestsList;

  LoadedPullRequestState({this.user, this.eventList, this.pullRequestsList})
      : super(user: user, eventList: eventList);

  @override
  String toString() => 'LoadedUserState $user';
}

class LoadedGitState extends PeopleState {
  final UserModel user;
  final List<EventModel> eventList;
  final Gists gist;

  LoadedGitState({this.user, this.eventList, this.gist});

  @override
  String toString() => 'LoadedUserState $user';
}

class ErrorUserState extends PeopleState {
  final String errorMessage;

  ErrorUserState(this.errorMessage);

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

class ErrorNextRepositoryState extends LoadedUserState {
  final String errorMessage;
  ErrorNextRepositoryState({UserModel user, this.errorMessage})
      : super(user: user);

  @override
  String toString() => 'ErrorUserState';
}
