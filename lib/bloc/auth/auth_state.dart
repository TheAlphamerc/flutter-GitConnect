import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => ([]);
}
class LoadingAuthState extends AuthState {}
class LoadingWebViewState extends AuthState {
  final bool loadingView;

  LoadingWebViewState({this.loadingView});
}
/// Initialized
class SucessState extends AuthState {
  final bool isSuccess;

  SucessState(this.isSuccess);
  @override
  List<Object> get props => ([this.isSuccess]);
}

class ErrorAuthState extends AuthState {
  final String errorMessage;

  ErrorAuthState(this.errorMessage);

  @override
  String toString() => 'ErrorAuthState';
}
