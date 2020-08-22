part of 'repo_bloc.dart';

abstract class RepoEvent extends Equatable {
  Stream<RepoState> applyAsync({RepoState currentState, RepoBloc bloc});
  final RepoRepository _issuesRepository =
      RepoRepository(apiGatway: GetIt.instance<ApiGateway>());
  @override
  List<Object> get props => [];
}

class LoadRepoEvent extends RepoEvent {
  final String name;
  final String owner;

  LoadRepoEvent({this.name, this.owner});
  @override
  Stream<RepoState> applyAsync({RepoState currentState, RepoBloc bloc}) async* {
    try {
      if (currentState is LoadedRepoState) {
        return;
      }
      yield LoadingRepoState();
      final model =
          await _issuesRepository.getRepository(name: name, owner: owner);
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
      print("Step 1");

      print("Step 2");
      final readme =
          await _issuesRepository.getReadme(name: name, owner: owner);
      print("Step 3");
      yield LoadReadmeState(model, readme);
    } catch (_, stackTrace) {
      print("Step 4");

      developer.log('$_',
          name: 'getReadmeEvent', error: _, stackTrace: stackTrace);
      yield ErrorReadmeState(_?.toString(), model);
    }
  }
}
