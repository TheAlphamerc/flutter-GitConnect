import 'package:flutter_github_connect/model/pul_request.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';

class PullrequestRepository {
  PullrequestRepository({this.apiGatway}) : assert(apiGatway != null);
  final ApiGateway apiGatway;
  Future<UserPullRequests> fetchRepoPullRequest({String owner,String name, String endCursor}) async{
    return await apiGatway.fetchRepoPullRequest(owner:owner,endCursor: endCursor,name:name);
  }
}

