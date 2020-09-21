import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/bloc/people/people_model.dart' as people;
import 'package:flutter_github_connect/bloc/search/repo_model.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';

abstract class PeopleState extends Equatable {
  @override
  List<Object> get props => ([]);
}

class LoadedUserState extends PeopleState {
  final UserModel user;

  LoadedUserState({@required this.user});

  @override
  String toString() => 'LoadedUserState $user';

  factory LoadedUserState.next(
      {UserModel userModel, UserModel currentUserModel}) {
    currentUserModel.repositories.nodes.addAll(userModel.repositories.nodes);
    currentUserModel.repositories.pageInfo = userModel.repositories.pageInfo;
    return LoadedUserState(user: currentUserModel);
  }
}

class LoadingNextRepositoriesState extends LoadedUserState {
  final UserModel user;
  LoadingNextRepositoriesState(
    this.user,
  ) : super(user: user);
}

class LoadingFollowState extends PeopleState {}

class LoadingPullRequestState extends PeopleState {}

class LoadedFollowState extends PeopleState {
  final people.FollowModel followModel;

  LoadedFollowState(this.followModel);

  factory LoadedFollowState.next({people.FollowModel model, people.FollowModel currentFollowModel}) {
    currentFollowModel.nodes.addAll(model.nodes);
    currentFollowModel.pageInfo = model.pageInfo;
    return LoadedFollowState(currentFollowModel);
  }
}
class LoadingNextFollowState extends LoadedFollowState{
  LoadingNextFollowState(people.FollowModel followers) : super(followers);
}

class ErrorPeopleState extends PeopleState {
  final String errorMessage;

  ErrorPeopleState(this.errorMessage);

  @override
  String toString() => 'ErrorPeopleState';
}

class LoadedEventsState extends LoadedUserState {
  final UserModel user;
  final List<EventModel> eventList;

  LoadedEventsState({@required this.user, this.eventList}) : super(user: user);

  @override
  String toString() => 'LoadedUserState $user';
}
class LoadedGitState extends PeopleState {
  final UserModel user;
  final List<EventModel> eventList;
  final Gists gist;

  LoadedGitState({this.user, this.eventList, this.gist});

  @override
  String toString() => 'LoadedUserState $user';

  factory LoadedGitState.next({Gists currenctGistModel, UserModel userModel, List<EventModel> eventList, Gists gistModel}) {
    currenctGistModel.nodes.addAll(gistModel.nodes);
    currenctGistModel.pageInfo = gistModel.pageInfo;
    print("New cursor is ${gistModel.pageInfo.endCursor}");
    return LoadedGitState(
        user: userModel,
        eventList: eventList,
        gist: currenctGistModel,);
  }
}

class LoadingNextGistState extends LoadedGitState {
  final Gists gist;

  LoadingNextGistState({this.gist, UserModel user, List<EventModel> eventList})
      : super(user: user, eventList: eventList, gist: gist);
}

class ErrorNextGistState extends LoadedGitState {
  final String errorMessage;
  ErrorNextGistState(
      {this.errorMessage,
      UserModel user,
      List<EventModel> eventList,
      Gists gist})
      : super(user: user, eventList: eventList, gist: gist);
}

class ErrorUserState extends PeopleState {
  final String errorMessage;

  ErrorUserState(this.errorMessage);

  @override
  String toString() => 'ErrorUserState';
}



class ErrorGitState extends LoadedEventsState {
  final String errorMessage;
  final UserModel user;
  final List<EventModel> eventList;
  ErrorGitState(this.errorMessage, {this.user, this.eventList})
      : super(user: user, eventList: eventList);

  @override
  String toString() => 'ErrorUserState';
}

class ErrorNextRepositoryState extends LoadedUserState {
  final String errorMessage;
  ErrorNextRepositoryState({UserModel user, this.errorMessage})
      : super(user: user);

  @override
  String toString() => 'ErrorUserState';
}

class LoadingPeopleActivityStates extends LoadedUserState{
  LoadingPeopleActivityStates({UserModel user,}):super(user: user);
}

class LoadedPeopleActivityStates extends LoadedUserState{
  final List<EventModel> eventList;
  final int pageNo;
  final UserModel user;
  final bool hasNextPage;
  LoadedPeopleActivityStates(this.eventList,  {this.pageNo,this.user,this.hasNextPage}):super(user: user);

  factory LoadedPeopleActivityStates.next({List<EventModel> currentList, List<EventModel> eventList, UserModel user, int pageNo}) {
    currentList.addAll(eventList);
    final hasNextPage = eventList != null && eventList.length == 20;
    return LoadedPeopleActivityStates(currentList,user:user,pageNo: pageNo,hasNextPage:hasNextPage);
  }
  @override
  String toString() => 'LoadedPeopleActivityStates';
}
class LoadingNextPeopleActivityStates extends LoadedPeopleActivityStates{
  LoadingNextPeopleActivityStates({UserModel user,List<EventModel> eventList}): super(eventList, user:user);
}
class ErrorActivitiesState extends LoadedUserState {
  final String errorMessage;

  ErrorActivitiesState(this.errorMessage, UserModel user): super(user: user);

  @override
  String toString() => 'ErrorActivitiesState';
}

class LoadingWatcherState extends PeopleState {}
class LoadedWatcherState extends PeopleState {
  final Watchers watchers;
  LoadedWatcherState(this.watchers);

  factory LoadedWatcherState.next({Watchers currentWatchers, Watchers watchers}){
   currentWatchers.userList.addAll(watchers.userList);
   currentWatchers.pageInfo = watchers.pageInfo;
   return LoadedWatcherState(currentWatchers);
  }
}
class ErrorWatchersState extends LoadedUserState {
  final String errorMessage;

  ErrorWatchersState(this.errorMessage);

  @override
  String toString() => 'ErrorWatchersState';
}
class LoadingNextWatcherState extends LoadedWatcherState {
  LoadingNextWatcherState(Watchers watchers) : super(watchers);
  
}

class ErrorNextWatchersState extends LoadedWatcherState {
  final String errorMessage;

  ErrorNextWatchersState(this.errorMessage,{Watchers watchers}): super(watchers);

  @override
  String toString() => 'ErrorNextWatchersState';
}

class LoadingStargezersState extends PeopleState {}
class LoadedStargezersState extends PeopleState {
  final Stargazers stargezers;
  LoadedStargezersState(this.stargezers);

  factory LoadedStargezersState.next({Stargazers currentStargazers, Stargazers stargezers}){
   currentStargazers.userList.addAll(stargezers.userList);
   currentStargazers.pageInfo = stargezers.pageInfo;
   return LoadedStargezersState(currentStargazers);
  }
}
class ErrorStargezersState extends LoadedUserState {
  final String errorMessage;

  ErrorStargezersState(this.errorMessage);

  @override
  String toString() => 'ErrorStargezersState';
}
class LoadingNextStargezersState extends LoadedStargezersState {
  LoadingNextStargezersState(Stargazers stargezers) : super(stargezers);
  
}

class ErrorNextStargezersState extends LoadedStargezersState {
  final String errorMessage;

  ErrorNextStargezersState(this.errorMessage,{Stargazers stargezers}): super(stargezers);

  @override
  String toString() => 'ErrorNextStargezerssState';
}