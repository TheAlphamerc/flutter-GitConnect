import 'package:flutter_github_connect/bloc/people/people_model.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';

class PeopleRepository {
  final ApiGateway apiGatway;

  PeopleRepository({this.apiGatway}) : assert(apiGatway != null);

  Future<FollowModel> fetchFollowersList(String login,{PeopleType type, String endCursor})async{
    return await  apiGatway.fetchFollowUserList(login:login,endCursor: endCursor,type: type);
  }
}
