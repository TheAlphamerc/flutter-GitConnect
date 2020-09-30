part of "index.dart";

abstract class FavouriteState extends Equatable {

  @override
  List<Object> get props => ([]);
}
class LoadingFavouriteReposState extends FavouriteState {}
/// UnInitialized


/// Initialized
class LoadedFavReposState extends FavouriteState {
  final List<RepositoriesNode> list;

  LoadedFavReposState(this.list);

  @override
  String toString() => 'LoadedFavReposState}';

  @override
  List<Object> get props => (list);
}


class ErrorFavouriteState extends FavouriteState {
  final String errorMessage;

  ErrorFavouriteState(this.errorMessage);
  
  @override
  String toString() => 'ErrorFavouriteState';
}
