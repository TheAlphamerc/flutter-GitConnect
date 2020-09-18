part of 'index.dart';

@immutable
abstract class PullrequestEvent extends Equatable{
  Stream<PullrequestState> getrepoPullrequest(
      {PullrequestState currentState, PullrequestBloc bloc});
  final PullrequestRepository _pullrequestRepository = PullrequestRepository(apiGatway: GetIt.instance<ApiGateway>());

  @override
  List<Object> get props => [];
}

class LoadRepoPullRequests extends PullrequestEvent {
  final String owner;
  final String name;
  final bool isNextRepoPull;

  @override
  String toString() => 'LoadPullrequestEvent';

  LoadRepoPullRequests({this.name, this.owner,this.isNextRepoPull = false}) : assert(owner != null),assert(name!= null);

  @override
  Stream<PullrequestState> getrepoPullrequest(
      {PullrequestState currentState, PullrequestBloc bloc}) async* {
    try {
      yield LoadingRepoPullRequest();

      final repoPullRequest = await _pullrequestRepository.fetchRepoPullRequest(name:name, owner:owner);
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
