
part of "index.dart";

@immutable
abstract class FavouriteEvent extends Equatable {
  @override
  List<Object> get props => [];

  Stream<FavouriteState> getFavouriteRepoList({FavouriteState currentState, FavouriteBloc bloc})async*{}
  Stream<FavouriteState> addRepoFavourite({FavouriteState currentState, FavouriteBloc bloc})async*{}
}

class UnFavouriteReposEvent extends FavouriteEvent {
  @override
  Stream<FavouriteState> getFavouriteRepoList({FavouriteState currentState, FavouriteBloc bloc}) async* {
    // yield UnFavouriteState();
  }
}

class AddRepotoFavouriteEvent extends FavouriteEvent {
  final RepositoriesNode repo;
  AddRepotoFavouriteEvent(this.repo);

   @override
  Stream<FavouriteState> addRepoFavourite({FavouriteState currentState, FavouriteBloc bloc}) async* {
    yield LoadingFavouriteReposState();
    await GetIt.instance.get<DbService>().addFavouriteRepository(repo);
    
    // var state = currentState as LoadedFavReposState;
    print(GetIt.instance.get<DbService>().favouriteList.length);
     yield LoadedFavReposState(GetIt.instance.get<DbService>().favouriteList);
  }

  @override
  String toString() => 'AddRepotoFavouriteEvent';
}

class LoadFavouriteReposEvent extends FavouriteEvent {
   
  @override
  Stream<FavouriteState> getFavouriteRepoList({FavouriteState currentState, FavouriteBloc bloc}) async* {
    try {
      yield LoadingFavouriteReposState();
      final list = await GetIt.instance.get<DbService>().getAllFavouriteRepoList();
      
      yield LoadedFavReposState(list);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadFavouriteEvent', error: _, stackTrace: stackTrace);
      yield ErrorFavouriteState( _?.toString());
    }
  }
  @override
  String toString() => 'LoadFavouriteReposEvent';
}
