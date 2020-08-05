import 'package:dio/dio.dart';
import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/bloc/issues/issues_model.dart';
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

class ApiGatwayImpl implements ApiGateway {
  final DioClient _dioClient;
  final SessionService _sessionService;
  ApiGatwayImpl(this._dioClient, this._sessionService);

  @override
  Future<UserModel> fetchUserProfile() async {
    try {
      var accesstoken = await _sessionService.loadSession();
      var login = await _sessionService.getUserName();
      assert(login != null);
      initClient(accesstoken);
      final result = await getUser(login);
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
  Future<List<RepositoryModel>> fetchRepositories() async {
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
          .map((e) => RepositoryModel.fromJson(e))
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
  Future<List> searchQuery({GithubSearchType type, String query}) async {
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
      final result = await searchQueryAsync(query, queryType);
      if (result.hasException) {
        print(result.exception.toString());
        return null;
      }
      // final userMap = result.data['search'] as Map<String, dynamic>;
      final user = model.Data.fromJson(result.data, type: type);

      return user.search.list;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<IssuesModel>> fetchIssues() async {
    try {
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      final result = await getIssues();
      if (result.hasException) {
        print(result.exception.toString());
        return null;
      }
      // final userMap = result.data['search'] as Map<String, dynamic>;
      final list = IssuesData.fromJson(result.data).viewer.issues.list;

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
  Future<UserPullRequests> fetchPullRequest() async {
    try {
      print("fetchPullRequest Init");
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      print("fetchPullRequest");
      var login = await _sessionService.getUserName();
      assert(login != null);
      final result = await getUserPullRequest(login);
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
  Future<Gists> fetchGistList()async {
    try {
      print("fetchPullRequest Init");
      var accesstoken = await _sessionService.loadSession();
      initClient(accesstoken);
      print("fetchPullRequest");
      var login = await _sessionService.getUserName();
      assert(login != null);
      final result = await getUserGistList(login);
      if (result.hasException) {
        print(result.exception.toString());
        return null;
      }
      print(result.data);
      // final userMap = result.data['search'] as Map<String, dynamic>;
      final list =
          GistResponse.fromJson(result.data).user.gists;

      return list;
    } catch (error) {
      throw error;
    }
  }
}
