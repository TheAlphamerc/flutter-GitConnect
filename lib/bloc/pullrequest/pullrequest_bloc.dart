part of 'index.dart';

class PullrequestBloc extends Bloc<PullrequestEvent, PullrequestState> {
  PullrequestBloc() : super(LoadingRepoPullRequest());

  @override
  Stream<PullrequestState> mapEventToState(
    PullrequestEvent event,
  ) async* {
    try {
      if(event is LoadRepoPullRequests){
        if(!event.isNextRepoPull){
          yield* event.getrepoPullrequest(currentState: state, bloc: this);
        }
        else{
          yield* event.getNextPullRequest(currentState: state, bloc: this);
        }
      }
      
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'PullrequestBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
