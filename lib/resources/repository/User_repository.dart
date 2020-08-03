import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/model/pul_request.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
class UserRepository {
  final ApiGateway apiGatway ;
  UserRepository({this.apiGatway}) : assert( apiGatway != null);

  Future<UserModel> fetchUserProfile() async{
    return await apiGatway.fetchUserProfile();
  }
  Future<List<EventModel>> fetchUserEvent() async{
    return await apiGatway.fetchUserEvent();
  }

  Future<UserPullRequests> fetchPullRequest() async{
    return await apiGatway.fetchPullRequest();
  }
}