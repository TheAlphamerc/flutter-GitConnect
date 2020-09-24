part of 'gist_bloc.dart';

abstract class GistEvent extends Equatable {
  @override
  List<Object> get props => [];

  Stream<GistState> loadGiistDetail({GistState currentState, GistBloc bloc}){}

  final GistRepository _gistRepository = GistRepository(apiGatway: GetIt.instance<ApiGateway>());
  
}

class LoadGistDetailEvent extends GistEvent {
  final String id;

  LoadGistDetailEvent(this.id) : assert(id != null);
  @override
  Stream<GistState> loadGiistDetail({GistState currentState, GistBloc bloc}) async* {
    try {
      if (currentState is LoadedGistDetailState) {
        return;
      }
      yield LoadingGistDetailState();
      final issues = await _gistRepository.getGistDetail(id);
      yield LoadedGistDetailState(issues);
    } catch (_, stackTrace) {
      log('$_', name: 'LoadIssuesEvent', error: _, stackTrace: stackTrace);
      yield ErrorGistDetailState(_?.toString());
    }
  }
}

class OnGistLoad extends GistEvent {
  OnGistLoad(this.login, {this.isLoadNextGist = false});

  final bool isLoadNextGist;
  final String login;

  @override
  Stream<GistState> getGist(
      {GistState currentState, GistBloc bloc}) async* {
    if (currentState is LoadedGitState) {
      return;
    }
    try {
      // yield LoadingUserState();

      final gistModel = await _gistRepository.fetchGistList(login: login);

      yield LoadedGitState(gist: gistModel);
    } catch (_, stackTrace) {
      log('$_', name: 'OnGistLoad', error: _, stackTrace: stackTrace);
      yield ErrorGitState(_?.toString());
    }
  }

  Stream<GistState> getNextGist( {GistState currentState, GistBloc bloc}) async* {
    try {
      final state = currentState as LoadedGitState;
      if (!state.gist.pageInfo.hasNextPage) {
        print("No Gist left");
        return;
      }
      yield LoadingNextGistState(gist: state.gist);
      
      print(state.gist.pageInfo.endCursor);
      final gistModel = await _gistRepository.fetchGistList(
          login: login, endCursor: state.gist.pageInfo.endCursor);
      yield LoadedGitState.next(
        currenctGistModel: state.gist,
        gistModel: gistModel,
      );
    } catch (_, stackTrace) {
      log('$_',
          name: 'OnGistLoadt', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedGitState;
      yield ErrorNextGistState(
        errorMessage: _?.toString(),
        gist: state.gist,
      );
    }
  }
}