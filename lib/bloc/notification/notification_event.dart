import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/notification_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotificationEvent extends Equatable {
  @override
  List<Object> get props => [];
  Stream<NotificationState> getNotificationList(
      {NotificationState currentState, NotificationBloc bloc});
  final NotificationRepository _userRepository =
      NotificationRepository(apiGatway: GetIt.instance<ApiGateway>());
}

class OnLoad extends NotificationEvent {
  final bool isLoadNextNotification;

  OnLoad({this.isLoadNextNotification = false});
  @override
  Stream<NotificationState> getNotificationList(
      {NotificationState currentState, NotificationBloc bloc}) async* {
    try {
      if (currentState is LoadedNotificationState) {
        return;
      }
      yield LoadingNotificationState();
      final list = await _userRepository.getNotificationsList(pageNo: 1);
      yield LoadedNotificationState(list: null, pageNo: 2, hasNextPage: list.length == 10);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'Load Repository Event', error: _, stackTrace: stackTrace);
      yield ErrorNotificationState(_?.toString());
    }
  }

  Stream<NotificationState> getNextNotifications(
      {NotificationState currentState, NotificationBloc bloc}) async* {
    try {
      final state = currentState as LoadedNotificationState;
      if (!state.hasNextPage) {
        print("No notification left");
        return;
      }
      yield LoadingNextNotificationState(state.list, state.pageNo, state.hasNextPage);
      final list = await _userRepository.getNotificationsList(pageNo: state.pageNo);
      yield LoadedNotificationState.next(
        currentList: state.list,
        notificationList: list,
        hasNextPage: list.length == 10,
        pageNo: state.pageNo + 1,
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadUserEvent', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedNotificationState;
      yield ErrorNextNotificationState(
        errorMessage: _?.toString(),
        list: state.list,
        hasNextPage: state.hasNextPage,
        pageNo: state.pageNo,
      );
    }
  }
}
