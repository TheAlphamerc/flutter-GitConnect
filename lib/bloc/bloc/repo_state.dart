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

class LoadingForksState extends RepoState {}
class LoadedForksState extends RepoState {
  final ForksModel forks;
  LoadedForksState(this.forks);

  factory LoadedForksState.next({ForksModel currentForks, ForksModel forks}){
   currentForks.nodes.addAll(forks.nodes);
   currentForks.pageInfo = forks.pageInfo;
   return LoadedForksState(currentForks);
  }
}
class ErrorForksState extends LoadedForksState {
  final String errorMessage;

  ErrorForksState(this.errorMessage, {ForksModel forks}): super(forks);

  @override
  String toString() => 'ErrorForksState';
}
class LoadingNextForksState extends LoadedForksState {
  LoadingNextForksState(ForksModel forks) : super(forks);
  
}

class ErrorNextForksState extends LoadedForksState {
  final String errorMessage;

  ErrorNextForksState(this.errorMessage,{ForksModel forks}): super(forks);

  @override
  String toString() => 'ErrorNextForkssState';
}