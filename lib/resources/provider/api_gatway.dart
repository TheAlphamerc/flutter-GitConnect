import 'package:flutter_github_connect/bloc/User/User_model.dart';

abstract class ApiGateway{
   Future<UserModel> fetchUserProfile();
}