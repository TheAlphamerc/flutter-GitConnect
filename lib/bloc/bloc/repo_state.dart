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

class LoadReadmeState extends LoadedRepoState {
  final RepositoryModel model;
  final String readme;
  LoadReadmeState(this.model, this.readme) : super(model);
}

class ErrorRepoState extends RepoState {
  final String errorMessage;
  ErrorRepoState(this.errorMessage);
}

class ErrorReadmeState extends LoadedRepoState {
  final RepositoryModel model;
  final String errorMessage;
  ErrorReadmeState(this.errorMessage, this.model) : super(model);
}
