import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/people/index.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  PeopleBloc() : super(LoadingFollowState());

  @override
  Stream<PeopleState> mapEventToState(
    PeopleEvent event,
  ) async* {
    try {
      if (event is LoadFollowEvent) {
        yield* event.fetchFollowersList(currentState: state, bloc: this);
      } else if (event is LoadUserEvent) {
        if (event.isLoadNextRepositories) {
          yield* event.getNextRepositories(currentState: state, bloc: this);
        } else {
          yield* event.getUser(currentState: state, bloc: this);
        }
      } else if (event is OnGistLoad) {
         if(event.isLoadNextGist){
          yield* event.getNextGist(currentState: state, bloc: this);
        }
        else{
          yield* event.getGist(currentState: state, bloc: this);
        }
        
      }else if (event is LoadPeopleActivitiesEvent){
        if(event.loadNextActivity){
          yield* event.getNextActivities(currentState: state, bloc: this);
        }else{
          yield* event.getActivities(currentState: state, bloc: this);
        }
      }
      else if (event is LoadWatchersEvent){
        if(event.isLoadNextWatchers){
          yield* event.getNextRepoWatchers(currentState: state, bloc: this);
        }else{
          yield* event.getRepoWatchers(currentState: state, bloc: this);
        }
      }
    } catch (_, stackTrace) {
      developer.log('$_', name: 'PeopleBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
