import 'package:flutter_github_connect/bloc/people/people_model.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';

class PeopleRepository {
  final ApiGateway apiGatway;

  PeopleRepository({this.apiGatway}) : assert(apiGatway != null);

  Future<Followers> fetchFollowersList(String login)async{
    return await  apiGatway.fetchFollowersList(login);
  }
  Future<Following> fetchFollowingList(String login)async{
    return await  apiGatway.fetchFollowingList(login);
  }
}
