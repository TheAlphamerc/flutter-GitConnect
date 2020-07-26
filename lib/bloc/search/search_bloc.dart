import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/bloc/search/search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(LoadingSearchState());

  @override
  Future<void> close() async {
    // dispose objects
    await super.close();
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    try {
      yield* event.searchQuery(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'RepoBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
