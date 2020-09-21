import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart';
import 'package:flutter_github_connect/bloc/people/people_model.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/model/pul_request.dart';
import 'package:flutter_github_connect/bloc/people/people_model.dart' as people;
import 'package:flutter_github_connect/bloc/issues/issues_model.dart' as issues;
import 'package:flutter_github_connect/bloc/search/model/search_userModel.dart'
    as model;
import 'package:flutter_github_connect/bloc/bloc/repo_response_model.dart';
abstract class ApiGateway{
   Future<UserModel> fetchUserProfile({String login});
   Future<UserModel>fetchNextRepositorries({String login, String endCursor});
   Future<List<EventModel>> fetchUserEvent({String login,int pageNo});
   Future<List<RepositoryModel2>> fetchRepositories();
   Future<List<NotificationModel>>  fetchNotificationList({int pageNo});
   Future<model.Search> searchQuery({GithubSearchType type, String query,String endCursor});
   Future<issues.Issues> fetchIssues({String login,String endCursor});
   Future<issues.Issues> fetchRepoIssues({String owner, String endCursor, String name});
   Future<UserPullRequests> fetchPullRequest({String login,endCursor});
   Future<Gists> fetchGistList({String login,String endCursor});
   Future<GistDetail> fetchGistDetail(String id);
   Future<people.FollowModel> fetchFollowUserList({String login,PeopleType type, String endCursor});
   Future<RepositoryModel> fetchRepository({String name, String owner});
   Future<String> fetchReadme({String name, String owner});
   Future<Watchers> fetchRepoWatchers({String name, String owner,String endCursor});
   Future<UserPullRequests> fetchRepoPullRequest({String owner, String endCursor, String name});
   Future<Stargazers> fetchRepoStargazers({String owner, String endCursor, String name});
}