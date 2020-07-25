import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/issues/issues_model.dart';

abstract class IssuesState extends Equatable {
  @override
  List<Object> get props => ([]);
}

class LoadingUserState extends IssuesState {}

/// Initialized
class LoadedIssuesState extends IssuesState {
  final List<IssuesModel> list;

  LoadedIssuesState(this.list);

  @override
  String toString() => 'LoadedIssuesState';
}

class ErrorIssuesState extends IssuesState {
  final String errorMessage;

  ErrorIssuesState(this.errorMessage);

  @override
  String toString() => 'ErrorIssuesState';
}
