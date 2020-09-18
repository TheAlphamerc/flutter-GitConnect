part of 'index.dart';

abstract class PullrequestState extends Equatable {
  @override
  List<Object> get props => ([]);
}


class LoadingRepoPullRequest extends PullrequestState {}
class LoadedRepoPullRequest extends PullrequestState {
  final UserPullRequests repoPullRequest;

  LoadedRepoPullRequest({this.repoPullRequest});

  factory LoadedRepoPullRequest.next({UserPullRequests currentpullRequestsList, UserPullRequests repoPullRequest}) {
   currentpullRequestsList.nodes.addAll(repoPullRequest.nodes);
    currentpullRequestsList.pageInfo = repoPullRequest.pageInfo;
    return LoadedRepoPullRequest(repoPullRequest: currentpullRequestsList); 
  }

  @override
  String toString() => 'LoadedRepoPullRequest';
}

class LoadingNextRepoPullRequestState extends LoadedRepoPullRequest{
  LoadingNextRepoPullRequestState(UserPullRequests repoPullRequest): super(repoPullRequest:repoPullRequest);
}
class ErrorRepoPullrequestState extends PullrequestState {
  ErrorRepoPullrequestState(int version, this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorPullrequestState';
}

class  ErrorNextRepoPullRequestState extends LoadedRepoPullRequest{
  final String errorMessage;
  ErrorNextRepoPullRequestState({this.errorMessage,UserPullRequests repoPullRequest}): super(repoPullRequest:repoPullRequest);
}