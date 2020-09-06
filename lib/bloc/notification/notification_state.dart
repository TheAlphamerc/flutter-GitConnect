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
  final int pageNo;
  final bool hasNextPage;
  
  LoadedNotificationState({this.hasNextPage,this.list,this.pageNo,});

  @override
  String toString() => 'LoadedUserState';

  factory LoadedNotificationState.next({List<NotificationModel> currentList, List<NotificationModel> notificationList, bool hasNextPage, int pageNo}) {
    currentList.addAll(notificationList);
    return LoadedNotificationState(list: currentList,pageNo: pageNo,hasNextPage: hasNextPage);
  }
}

class ErrorNotificationState extends NotificationState {
  final String errorMessage;

  ErrorNotificationState(this.errorMessage);

  @override
  String toString() => 'ErrorNotificationState';
}

class LoadingNextNotificationState extends LoadedNotificationState {
  LoadingNextNotificationState(List<NotificationModel> list, int pageNo, bool hasNextPage):super(list: list,pageNo: pageNo,hasNextPage: hasNextPage);
  @override
  String toString() => 'LoadingNextNotificationState';
}
class ErrorNextNotificationState extends NotificationState {
  final String errorMessage;

  ErrorNextNotificationState({this.errorMessage,bool hasNextPage, List<NotificationModel> list, int pageNo});

  @override
  String toString() => 'ErrorNextNotificationState';
}