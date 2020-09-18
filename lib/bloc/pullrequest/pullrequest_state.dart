part of 'index.dart';

abstract class PullrequestState extends Equatable {
  @override
  List<Object> get props => ([]);
}

class LoadingRepoPullRequest extends PullrequestState {}

class LoadedRepoPullRequest extends PullrequestState {
  final UserPullRequests repoPullRequest;

  LoadedRepoPullRequest({this.repoPullRequest});

  factory LoadedRepoPullRequest.next(
      {UserPullRequests currentpullRequestsList,
      UserPullRequests repoPullRequest}) {
    currentpullRequestsList.nodes.addAll(repoPullRequest.nodes);
    currentpullRequestsList.pageInfo = repoPullRequest.pageInfo;
    return LoadedRepoPullRequest(repoPullRequest: currentpullRequestsList);
  }

  @override
  String toString() => 'LoadedRepoPullRequest';
}

class LoadingNextRepoPullRequestState extends LoadedRepoPullRequest {
  LoadingNextRepoPullRequestState(UserPullRequests repoPullRequest)
      : super(repoPullRequest: repoPullRequest);
}

class ErrorRepoPullrequestState extends PullrequestState {
  ErrorRepoPullrequestState(int version, this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorPullrequestState';
}

class ErrorNextRepoPullRequestState extends LoadedRepoPullRequest {
  final String errorMessage;
  ErrorNextRepoPullRequestState(
      {this.errorMessage, UserPullRequests repoPullRequest})
      : super(repoPullRequest: repoPullRequest);
}

class LoadingPullRequestState extends PullrequestState {}

class LoadedPullRequestState extends PullrequestState {
  final UserPullRequests pullRequestsList;

  LoadedPullRequestState({this.pullRequestsList});

  factory LoadedPullRequestState.next(
      {UserPullRequests currentpullRequestsList,
      UserPullRequests pullRequestsList}) {
    currentpullRequestsList.nodes.addAll(pullRequestsList.nodes);
    currentpullRequestsList.pageInfo = pullRequestsList.pageInfo;
    return LoadedPullRequestState(pullRequestsList: currentpullRequestsList);
  }

  @override
  String toString() => 'LoadedUserState';
}

class LoadingNextPullRequestState extends LoadedPullRequestState {
  LoadingNextPullRequestState(UserPullRequests pullRequestsList)
      : super(pullRequestsList: pullRequestsList);
}

class ErrorPullRequestState extends PullrequestState {
  final String errorMessage;
  ErrorPullRequestState(this.errorMessage);
    
  @override
  String toString() => 'ErrorUserState';
}
class ErrorNextPullRequestState extends LoadedPullRequestState {
  final String errorMessage;
  ErrorNextPullRequestState({
    this.errorMessage,
    UserPullRequests pullRequestsList,
  }) : super(pullRequestsList: pullRequestsList);
}
