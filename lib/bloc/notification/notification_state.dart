import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart';

abstract class NotificationState extends Equatable {
  @override
  List<Object> get props => ([]);
}

class LoadingNotificationState extends NotificationState {}

/// Initialized
class LoadedNotificationState extends NotificationState {
  final List<NotificationModel> list;

  LoadedNotificationState({this.list});

  @override
  String toString() => 'LoadedUserState $list';
}

class ErrorNotificationState extends NotificationState {
  final String errorMessage;

  ErrorNotificationState(this.errorMessage);

  @override
  String toString() => 'ErrorNotificationState';
}
