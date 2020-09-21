import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/bloc/people/people_model.dart';
import 'package:flutter_github_connect/bloc/search/repo_model.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';

class PeopleRepository {
  final ApiGateway apiGatway;

  PeopleRepository({this.apiGatway}) : assert(apiGatway != null);

  Future<FollowModel> fetchFollowersList(String login,{PeopleType type, String endCursor})async{
    return await  apiGatway.fetchFollowUserList(login:login,endCursor: endCursor,type: type);
  }
  Future<Watchers> getRepoWatchers({String name, String owner,String endCursor}) async {
    assert(name != null, owner != null);
    return await apiGatway.fetchRepoWatchers(name: name, owner: owner,endCursor:endCursor);
  }
  Future<Stargazers> fetchRepoStargazers({String name, String owner,String endCursor}) async {
    assert(name != null, owner != null);
    return await apiGatway.fetchRepoStargazers(name: name, owner: owner,endCursor:endCursor);
  }
}
