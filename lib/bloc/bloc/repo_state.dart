part of 'repo_bloc.dart';

abstract class RepoState extends Equatable {
  const RepoState();

  @override
  List<Object> get props => [];
}

class LoadingRepoState extends RepoState {}

class LoadedRepoState extends RepoState {
  final RepositoryModel model;
  LoadedRepoState(this.model);
}

class ErrorRepoState extends RepoState {
  final String errorMessage;

  ErrorRepoState(this.errorMessage);
}
