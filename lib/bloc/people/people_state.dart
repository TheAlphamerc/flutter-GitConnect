import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/people/people_model.dart';

abstract class PeopleState extends Equatable {
  @override
  List<Object> get props => ([]);
}

/// Initialized
class LoadingFollowersState extends PeopleState {}

class LoadingFollowingState extends PeopleState {}

class LoadedFollowersState extends PeopleState {
  final Followers followers;

  LoadedFollowersState(this.followers);
}
class LoadedFollowingState extends PeopleState {
  final Following following;

  LoadedFollowingState(this.following);
}

class ErrorPeopleState extends PeopleState {
  final String errorMessage;

  ErrorPeopleState(this.errorMessage);

  @override
  String toString() => 'ErrorPeopleState';
}
