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

class LoadedGitState extends GistState {
  final Gists gist;

  LoadedGitState({this.gist});

  @override
  String toString() => 'LoadedUserState';

  factory LoadedGitState.next({Gists currenctGistModel,Gists gistModel}) {
    currenctGistModel.nodes.addAll(gistModel.nodes);
    currenctGistModel.pageInfo = gistModel.pageInfo;
    print("New cursor is ${gistModel.pageInfo.endCursor}");
    return LoadedGitState(gist: currenctGistModel,);
  }
}

class LoadingNextGistState extends LoadedGitState {
  final Gists gist;

  LoadingNextGistState({this.gist,}): super(gist: gist);
}

class ErrorNextGistState extends LoadedGitState {
  final String errorMessage;
  ErrorNextGistState({this.errorMessage,Gists gist}): super(gist: gist);
}

class ErrorUserState extends GistState {
  final String errorMessage;

  ErrorUserState(this.errorMessage);

  @override
  String toString() => 'ErrorUserState';
}

class ErrorGitState extends LoadedGitState {
  final String errorMessage;
  ErrorGitState(this.errorMessage, );

  @override
  String toString() => 'ErrorUserState';
}

