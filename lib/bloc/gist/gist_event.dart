part of 'gist_bloc.dart';

abstract class GistEvent extends Equatable {
  @override
  List<Object> get props => [];

  Stream<GistState> loadAsync({GistState currentState, GistBloc bloc});

  final GistRepository _gistRepository =
      GistRepository(apiGatway: GetIt.instance<ApiGateway>());
}

class LoadGistDetailEvent extends GistEvent {
  final String id;

  LoadGistDetailEvent(this.id) : assert(id != null);
  @override
  Stream<GistState> loadAsync({GistState currentState, GistBloc bloc}) async* {
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
