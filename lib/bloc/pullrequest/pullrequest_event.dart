part of 'index.dart';

@immutable 
abstract class PullrequestEvent extends Equatable{
  final PullrequestRepository _pullrequestRepository = PullrequestRepository(apiGatway: GetIt.instance<ApiGateway>());
  Stream<PullrequestState> getrepoPullrequest({PullrequestState currentState, PullrequestBloc bloc}) async* {}
  Stream<PullrequestState> getPullRequest({PullrequestState currentState, PullrequestBloc bloc}) async* {}
  @override
  List<Object> get props => [];
}

class LoadRepoPullRequests extends PullrequestEvent {
  final String owner;
  final String name;
  final int count;
  final bool isNextRepoPull;
 

  LoadRepoPullRequests({this.name, this.owner,this.count,this.isNextRepoPull = false}) : assert(owner != null),assert(name!= null);

  @override
  Stream<PullrequestState> getrepoPullrequest(
      {PullrequestState currentState, PullrequestBloc bloc}) async* {
    try {
      yield LoadingRepoPullRequest();

      final repoPullRequest = count == 0 ? null : await _pullrequestRepository.fetchRepoPullRequest(name:name, owner:owner);
      yield LoadedRepoPullRequest(repoPullRequest: repoPullRequest);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadPullrequestEvent', error: _, stackTrace: stackTrace);
      yield ErrorRepoPullrequestState(0, _?.toString());
    }
  }

  Stream<PullrequestState> getNextPullRequest({PullrequestState currentState, PullrequestBloc bloc}) async* {
    try {
      final state = currentState as LoadedRepoPullRequest;
      if (!state.repoPullRequest.pageInfo.hasNextPage) {
        print("No pull request left");
        return;
      }
      yield LoadingNextRepoPullRequestState(state.repoPullRequest);

      final newPullRequestList = await _pullrequestRepository.fetchRepoPullRequest(
              owner: owner,
              name: name,
              endCursor: state.repoPullRequest.pageInfo.endCursor);
      yield LoadedRepoPullRequest.next( currentpullRequestsList: state.repoPullRequest,repoPullRequest: newPullRequestList);
    } catch (_, stackTrace) {
      developer.log('$_',name: 'OnPullRequestLoad', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedRepoPullRequest;
      yield ErrorNextRepoPullRequestState(
        errorMessage: _?.toString(),
        repoPullRequest: state.repoPullRequest,
      );
    }
  }
}

class OnPullRequestLoad extends PullrequestEvent {
  OnPullRequestLoad(this.login, {this.count,this.isLoadNextIssues = false});

  final bool isLoadNextIssues;
  final String login;
  final int count;
  @override
  Stream<PullrequestState> getPullRequest(
      {PullrequestState currentState, PullrequestBloc bloc}) async* {
    if (currentState is LoadedPullRequestState) {
      return;
    }
    try {
      yield LoadingPullRequestState();
      final pullRequestsList = count == 0 ? null : await _pullrequestRepository.fetchUserPullRequest(login:login);
      yield LoadedPullRequestState(pullRequestsList: pullRequestsList);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'OnPullRequestLoad', error: _, stackTrace: stackTrace);
      yield ErrorPullRequestState(
        _?.toString(),
      );
    }
  }

  Stream<PullrequestState> getNextPullRequest(
      {PullrequestState currentState, PullrequestBloc bloc}) async* {
    try {
      final state = currentState as LoadedPullRequestState;
      if (!state.pullRequestsList.pageInfo.hasNextPage) {
        print("No pull request left");
        return;
      }
      yield LoadingNextPullRequestState(
           state.pullRequestsList);
      final newPullRequestList = await _pullrequestRepository.fetchUserPullRequest(login:login, endCursor: state.pullRequestsList.pageInfo.endCursor);
      yield LoadedPullRequestState.next(
          currentpullRequestsList: state.pullRequestsList,
          pullRequestsList: newPullRequestList);
    } catch (_, stackTrace) {
      developer.log('$_',name: 'OnPullRequestLoad', error: _, stackTrace: stackTrace);
      final state = currentState as LoadedPullRequestState;
      yield ErrorNextPullRequestState(
        errorMessage: _?.toString(),
        pullRequestsList: state.pullRequestsList,
      );
    }
  }
}
