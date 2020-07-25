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
  LoadedSearchState(this.list, this.type);
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

class ErrorRepoState extends SearchState {
  final String errorMessage;

  ErrorRepoState(int version, this.errorMessage);
  @override
  String toString() => 'ErrorRepoState';
}
