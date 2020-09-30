part of "index.dart";

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {

  FavouriteBloc() : super(LoadingFavouriteReposState());

  @override
  Stream<FavouriteState> mapEventToState(
    FavouriteEvent event,
  ) async* {
    try {
      if(event is LoadFavouriteReposEvent){
        yield* event.getFavouriteRepoList(currentState: state, bloc: this);
      }else if(event is AddRepotoFavouriteEvent){
        yield* event.addRepoFavourite(currentState: state, bloc: this);
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'FavouriteBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
