import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/repository/gist_repository.dart';
import 'package:get_it/get_it.dart';

part 'gist_event.dart';
part 'gist_state.dart';

class GistBloc extends Bloc<GistEvent, GistState> {
  GistBloc() : super(LoadingGistDetailState());

  @override
  Stream<GistState> mapEventToState(
    GistEvent event,
  ) async* {
    try {
      if (event is LoadGistDetailEvent) {
        yield*  event.loadGiistDetail();
      }else if (event is OnGistLoad) {
         if(event.isLoadNextGist){
          yield* event.getNextGist(currentState: state, bloc: this);
        }
        else{
          yield* event.getGist(currentState: state, bloc: this);
        }
        
      }
    } catch (_, stackTrace) {
      log('$_', name: 'IssuesBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
