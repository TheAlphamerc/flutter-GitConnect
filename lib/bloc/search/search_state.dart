import 'package:equatable/equatable.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/issues/issues_model.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/bloc/search/model/search_userModel.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => ([]);
}

class LoadingSearchState extends SearchState {}

/// Initialized
class LoadedSearchState extends SearchState {
  final List<dynamic> list;
  final GithubSearchType type;
  final String endCursor;
  final bool hasNextPage;

  LoadedSearchState({this.list, this.type, this.endCursor, this.hasNextPage});
  factory LoadedSearchState.next(
      {List<dynamic> dynamicList,
      List<dynamic> list,
      GithubSearchType type,
      String endCursor,
      bool hasNextPage}) {
    List<dynamic> returnlist = [];
    returnlist.addAll(dynamicList);
    returnlist.addAll(list);
    print("List length: ${returnlist.length}");
    return LoadedSearchState(
      list: returnlist,
      endCursor: endCursor,
      type: type,
      hasNextPage: hasNextPage,
    );
  }
  @override
  String toString() => 'LoadedRepositoriesState';

  List<SearchUser> toUSerList() {
    List<SearchUser> userList = [];
    list
      ..forEach((element) {
        userList.add(element);
      });
    return userList;
  }

  List<RepositoriesNode> toRepositoryList() {
    List<RepositoriesNode> userList = [];
    if (list != null) {
      list
        ..forEach((element) {
          if (!(element is RepositoriesNode)) {
            return;
          }
          if (element.type != "Repository") {
            return;
          }
          userList.add(element);
        });
    }
    return userList;
  }

  // Todo : Need to implement
  List<IssuesModel> toPullRequest() {
    List<IssuesModel> userList = [];
    if (list != null) {
      list
        ..forEach((element) {
          if (element.type != "PullRequest") {
            return;
          }
          userList.add(element);
        });
    }
    return userList;
  }

  List<IssuesModel> toIssueList() {
    List<IssuesModel> userList = [];
    if (list != null) {
      list
        ..forEach((element) {
          if (element.type != "Issue") {
            return;
          }
          userList.add(element);
        });
    }
    return userList;
  }
}

class LoadingNextSearchState extends LoadedSearchState {
  final List<dynamic> list;
  final GithubSearchType type;
  final String endCursor;
  final bool hasNextPage;

  LoadingNextSearchState(
      {this.list, this.type, this.endCursor, this.hasNextPage})
      : super(
            endCursor: endCursor,
            type: type,
            list: list,
            hasNextPage: hasNextPage);
}

class ErrorRepoState extends SearchState {
  final String errorMessage;

  ErrorRepoState(this.errorMessage);
  @override
  String toString() => 'ErrorRepoState';
}
class ErrorNextRepoState extends LoadedSearchState {
  final String errorMessage;

  ErrorNextRepoState( this.errorMessage,{
      List<dynamic> list,
      GithubSearchType type,
      String endCursor,
      bool ,hasNextPage}):super(list:list,type:type,endCursor:endCursor,hasNextPage:hasNextPage);
  @override
  String toString() => 'ErrorNextRepoState';
}
