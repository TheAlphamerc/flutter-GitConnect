import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/notification/index.dart';
import 'package:flutter_github_connect/bloc/search/index.dart';

abstract class ApiGateway{
   Future<UserModel> fetchUserProfile();
   Future<List<RepositoryModel>> fetchRepositories();
   Future<List<NotificationModel>>  fetchNotificationList();
   Future<List<dynamic>> searchQuery({GithubSearchType type, String query});
}