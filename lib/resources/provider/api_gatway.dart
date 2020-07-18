import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/repo/index.dart';

abstract class ApiGateway{
   Future<UserModel> fetchUserProfile();
   Future<List<RepositoryModel>> fetchRepositories();
}