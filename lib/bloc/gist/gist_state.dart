part of 'gist_bloc.dart';

abstract class GistState extends Equatable {
  const GistState();

  @override
  List<Object> get props => [];
}

class LoadingGistDetailState extends GistState {}

class LoadedGistDetailState extends GistState {
  final GistDetail model;

  LoadedGistDetailState(this.model);
}

class ErrorGistDetailState extends GistState {
  final String errorMessage;

  ErrorGistDetailState(this.errorMessage);

  @override
  String toString() => 'ErrorIssuesState';
}
