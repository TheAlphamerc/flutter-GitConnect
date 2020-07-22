import 'dart:async';
import 'dart:developer' as developer;

import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart';
import 'package:flutter_github_connect/resources/provider/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/User_repository.dart';
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
  @override
  Stream<NotificationState> getNotificationList(
      {NotificationState currentState, NotificationBloc bloc}) async* {
    try {
      if (currentState is LoadedNotificationState) {
        return;
      }
      yield LoadingNotificationState();
      final list = await _userRepository.getNotificationsList();
      yield LoadedNotificationState(list: list);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'Load Repository Event', error: _, stackTrace: stackTrace);
      yield ErrorNotificationState(_?.toString());
    }
  }
}
