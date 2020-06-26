import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  UserState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  UserState getStateCopy();

  UserState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnUserState extends UserState {

  UnUserState(int version) : super(version);

  @override
  String toString() => 'UnUserState';

  @override
  UnUserState getStateCopy() {
    return UnUserState(0);
  }

  @override
  UnUserState getNewVersion() {
    return UnUserState(version+1);
  }
}

/// Initialized
class InUserState extends UserState {
  final String hello;

  InUserState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InUserState $hello';

  @override
  InUserState getStateCopy() {
    return InUserState(version, hello);
  }

  @override
  InUserState getNewVersion() {
    return InUserState(version+1, hello);
  }
}

class ErrorUserState extends UserState {
  final String errorMessage;

  ErrorUserState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorUserState';

  @override
  ErrorUserState getStateCopy() {
    return ErrorUserState(version, errorMessage);
  }

  @override
  ErrorUserState getNewVersion() {
    return ErrorUserState(version+1, 
    errorMessage);
  }
}
