import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/model/pul_request.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
class UserRepository {
  final ApiGateway apiGatway ;
  UserRepository({this.apiGatway}) : assert( apiGatway != null);

  Future<UserModel> fetchUserProfile({String login}) async{
    return await apiGatway.fetchUserProfile(login:login);
  }
  Future<UserModel> fetchNextRepositorries({String login,String endCursor}) async{
    return await apiGatway.fetchNextRepositorries(login:login,endCursor: endCursor);
  }
  Future<List<EventModel>> fetchUserEvent({String login,int pageNo}) async{
    return await apiGatway.fetchUserEvent(login:login,pageNo: pageNo);
  }

  Future<UserPullRequests> fetchPullRequest({String login, String endCursor}) async{
    return await apiGatway.fetchPullRequest(login:login,endCursor: endCursor);
  }

  Future<Gists> fetchGistList({String login,String endCursor}) async{
    return await apiGatway.fetchGistList(login:login,endCursor:endCursor);
  }
}