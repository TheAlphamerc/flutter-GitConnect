import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';

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

  @override
  String toString() => 'LoadedUserState $user';
}

class LoadedEventsState extends LoadedUserState {
  final UserModel user;
  final List<EventModel> eventList;

  LoadedEventsState({@required this.user,this.eventList}) : super(user);

  @override
  String toString() => 'LoadedUserState $user';
}

class ErrorUserState extends UserState {
  final String errorMessage;

  ErrorUserState(this.errorMessage);

  @override
  String toString() => 'ErrorUserState';
}
