part of 'repo_bloc.dart';

abstract class RepoEvent extends Equatable {
  Stream<RepoState> loadRepoDetail({RepoState currentState, RepoBloc bloc})async* {}
  Stream<RepoState> getRepoForks({RepoState currentState, RepoBloc bloc})async* {}
  Stream<RepoState> getNextRepoForks({RepoState currentState, RepoBloc bloc})async* {}
  final RepoRepository _repoRepository =   RepoRepository(apiGatway: GetIt.instance<ApiGateway>());
  @override
  List<Object> get props => [];
}

class LoadRepoEvent extends RepoEvent {
  final String name;
  final String owner;

  LoadRepoEvent({this.name, this.owner});
  @override
  Stream<RepoState> loadRepoDetail({RepoState currentState, RepoBloc bloc}) async* {
    try {
      if (currentState is LoadedRepoState) {
        return;
      }
      yield LoadingRepoState();
      final model =
          await _repoRepository.getRepository(name: name, owner: owner);
      yield LoadedRepoState(
        model,
      );

      yield* getReadme(model);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadRepoEvent', error: _, stackTrace: stackTrace);
      yield ErrorRepoState(_?.toString());
    }
  }

  Stream<RepoState> getReadme(RepositoryModel model) async* {
    try {
      final readme =
          await _repoRepository.getReadme(name: name, owner: owner);
      yield LoadReadmeState(model, readme);
    } on ApiDataNotFoundException catch (_) {
      developer.log(
        "Readme file not available for $name reposotory",
        name: "LoadRepoEvent",
      );
       yield ErrorReadmeState(_?.toString(), model);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: "LoadRepoEvent", error: _, stackTrace: stackTrace);
      yield ErrorReadmeState(_?.toString(), model);
    }
  }
}

class LoadForksEvent extends RepoEvent {
  final bool isLoadNextForks;
  final String name;
  final String owner;
  final int count;
  LoadForksEvent({this.name,this.owner,this.count,this.isLoadNextForks=false}) : assert(name != null), assert(owner!= null);
  @override
  Stream<RepoState> getRepoForks(
      {RepoState currentState, RepoBloc bloc}) async* {
    try {
      yield LoadingForksState();
      final list = count == 0 ? null : await _repoRepository.fetchRepoForks(name: name, owner: owner);
      yield LoadedForksState(list);
    } catch (_, stackTrace) {
      developer.log('$_',name: 'LoadForksEvent', error: _, stackTrace: stackTrace);
      yield ErrorForksState(_?.toString());
    }
  }
  @override
  Stream<RepoState> getNextRepoForks(
      {RepoState currentState, RepoBloc bloc}) async* {
    final state = currentState as LoadedForksState;
    try {
      if (!state.forks.pageInfo.hasNextPage) {
        print("No watchers left");
        return;
      }
      yield LoadingNextForksState(state.forks);

     final list = await _repoRepository.fetchRepoForks(name: name, owner: owner,endCursor:state.forks.pageInfo.endCursor);
      yield LoadedForksState.next(currentForks: state.forks, forks:list);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'RepoEvent', error: _, stackTrace: stackTrace);
      yield ErrorNextForksState(_?.toString(), forks: state.forks);
    }
  }
}