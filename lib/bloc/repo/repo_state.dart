import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/repo/index.dart';

abstract class RepoState extends Equatable {
  @override
  List<Object> get props => ([]);


  
}
class LoadingUserState extends RepoState {}
/// Initialized
class LoadedRepositoriesState extends RepoState {
  final List<RepositoryModel> list;

  LoadedRepositoriesState(this.list);
  @override
  String toString() => 'LoadedRepositoriesState';

}

class ErrorRepoState extends RepoState {
  final String errorMessage;

  ErrorRepoState(int version, this.errorMessage);
  @override
  String toString() => 'ErrorRepoState';
}
