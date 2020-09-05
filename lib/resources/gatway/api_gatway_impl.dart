import 'package:dio/dio.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/bloc/issues/issues_model.dart' as issues;
import 'package:flutter_github_connect/bloc/notification/index.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/bloc/search/model/search_userModel.dart'
    as model;
import 'package:flutter_github_connect/helper/config.dart';
import 'package:flutter_github_connect/model/pul_request.dart';
import 'package:flutter_github_connect/resources/dio_client.dart';
import 'package:flutter_github_connect/resources/graphql_client.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/resources/service/session_service.dart';
import 'package:flutter_github_connect/bloc/people/people_model.dart' as people;
import 'package:flutter_github_connect/bloc/bloc/repo_response_model.dart';

class ApiGatwayImpl implements ApiGateway {
  final DioClient _dioClient;
  final SessionService _sessionService;
  ApiGatwayImpl(this._dioClient, this._sessionService);

  @override
  Future<UserModel> fetchUserProfile({String login}) async {
    try {
      var accesstoken = await _sessionService.loadSession();
      var username = login ?? await _sessionService.getUserName();
      assert(username != null);
      initClient(accesstoken);
      final result = await getUser(username);
      if (result.hasException) {
        print(result.exception.toString());
        throw result.exception;
      }

      final userMap = result.data['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(userMap);

      return user;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<RepositoryModel2>> fetchRepositories() async {
    try {
      var accesstoken = await _sessionService.loadSession();
      var response = await _dioClient.get(
        Config.repos,
        options: Options(
          headers: {
            'Authorization': 'token $accesstoken',
            'Accept': 'application/vnd.github.v3+json'
          },
        ),
      );
      final list = _dioClient
          .getJsonBodyList(response)
          .map((e) => RepositoryModel2.fromJson(e))
          .toList();
      return list;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<NotificationModel>> fetchNotificationList() async {
    try {
      var accesstoken = await _sessionService.loadSession();
      var response = await _dioClient.get(
        Config.notificationsList,
        options: Options(
          headers: {'Authorization': 'token $accesstoken'},
        ),
      );
      List<NotificationModel> list = [];
      list = _dioClient.getJsonBodyList(response).map((value) {
        return NotificationModel.fromJson(value);
      }).toList();
      print(list.length);
      return list;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<model.Search> searchQuery(
      {GithubSearchType type, String query, String endCursor}) async {
    try {
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      String queryType;
      switch (type) {
        case GithubSearchType.People:
          queryType = "USER";
          break;
        case GithubSearchType.Repository:
          queryType = "REPOSITORY";
          break;
        case GithubSearchType.PullRequest:
          queryType = "USER";
          break;
        case GithubSearchType.Issue:
          queryType = "ISSUE";
          break;
        case GithubSearchType.ORganisation:
          queryType = "USER";
          break;

        default:
          queryType = "USER";
          break;
      }
      final result = await searchQueryAsync(query, queryType, endCursor);
      if (result.hasException) {
        print(result.exception.toString());
        throw result.exception;
      }
      // final userMap = result.data['search'] as Map<String, dynamic>;
      final user = model.Data.fromJson(result.data, type: type);

      return user.search;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<issues.Issues> fetchIssues({String login,String endCursor}) async {
    try {
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      var username = login ?? await _sessionService.getUserName();
      final result = await getIssues(username,endCursor);
      if (result.hasException) {
        print(result.exception.toString());
        return null;
      }
      final issueMap = result.data['user'] as Map<String, dynamic>;
      final list = issues.Issues.fromJson(issueMap["issues"]);

      return list;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<EventModel>> fetchUserEvent() async {
    try {
      var accesstoken = await _sessionService.loadSession();
      var login = await _sessionService.getUserName();
      assert(login != null);
      var response = await _dioClient.get(
        Config.getEvent(login),
        options: Options(
          headers: {
            'Authorization': 'token $accesstoken',
            'Accept': 'application/vnd.github.v3+json'
          },
        ),
      );
      List<EventModel> list = [];
      list = _dioClient.getJsonBodyList(response).map((value) {
        return EventModel.fromJson(value);
      }).toList();
      print(list.length);
      return list;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<UserPullRequests> fetchPullRequest({String login,endCursor}) async {
    try {
      print("fetchPullRequest Init");
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      print("fetchPullRequest");
      var username = login ?? await _sessionService.getUserName();
      assert(login != null);
      final result = await getUserPullRequest(username,endCursor);
      if (result.hasException) {
        print(result.exception.toString());
        return null;
      }
      print(result.data);
      // final userMap = result.data['search'] as Map<String, dynamic>;
      final list =
          UserPullRequestResponse.fromJson(result.data).user.pullRequests;

      return list;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<Gists> fetchGistList({String login}) async {
    try {
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      var username = login ?? await _sessionService.getUserName();
      assert(username != null);
      final result = await getUserGistList(username);
      if (result.hasException) {
        print(result.exception.toString());
        return null;
      }
      print(result.data);
      // final userMap = result.data['search'] as Map<String, dynamic>;
      final list = GistResponse.fromJson(result.data).user.gists;

      return list;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<people.Followers> fetchFollowersList(String login) async {
    try {
      assert(login != null);
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      print("Get Followers list");
      final result = await getFollowerList(login);
      if (result.hasException) {
        print(result.exception.toString());
        throw result.exception;
      }
      print(result.data);
      // final userMap = result.data['search'] as Map<String, dynamic>;
      final list = people.User.fromJson(result.data["user"]).followers;

      return list;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<people.Following> fetchFollowingList(String login) async {
    try {
      assert(login != null);
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      print("Get Following list");
      final result = await getFollowingList(login);
      if (result.hasException) {
        print(result.exception.toString());
        throw result.exception;
      }
      print(result.data);
      // final userMap = result.data['search'] as Map<String, dynamic>;
      final list = people.User.fromJson(result.data["user"]).following;

      return list;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<RepositoryModel> fetchRepository({String name, String owner}) async {
    try {
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      final result = await getRepositoryDetail(name: name, owner: owner);
      if (result.hasException) {
        print(result.exception.toString());
        throw result.exception;
      }

      final map = result.data['repository'] as Map<String, dynamic>;
      final repository = RepositoryModel.fromJson(map);

      return repository;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> fetchReadme({String name, String owner}) async {
    try {
      var accesstoken = await _sessionService.loadSession();
      var login = await _sessionService.getUserName();
      assert(login != null);
      var response = await _dioClient.get(
        null,
        completeUrl: Config.getReadme(name: name, owner: owner),
        options: Options(
          headers: {
            'Authorization': 'token $accesstoken',
            'Accept': 'application/vnd.github.v3+json'
          },
        ),
      );

      final String text = response.data as String;
      return text;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<UserModel> fetchNextRepositorries(
      {String login, String endCursor}) async {
    assert(endCursor != null && login != null);
    try {
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      final result =
          await getNextRepositoriesList(login: login, endCursor: endCursor);
      if (result.hasException) {
        print(result.exception.toString());
        throw result.exception;
      }
      final userMap = result.data['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(userMap);

      return user;
    } catch (error) {
      throw error;
    }
  }
}
