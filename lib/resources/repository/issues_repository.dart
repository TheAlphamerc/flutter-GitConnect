import 'package:flutter_github_connect/bloc/issues/index.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';

class IssuesRepository {
  IssuesRepository({this.apiGatway}) : assert(apiGatway != null);
  final ApiGateway apiGatway;

  Future<Issues> getIssues({String login,String endCursor}) async {
    return await apiGatway.fetchIssues(login:login, endCursor: endCursor);
  }

  Future<Issues> getRepoIssues({String owner,String name,String endCursor}) async {
    return await apiGatway.fetchRepoIssues(owner:owner,name:name,endCursor: endCursor);
  }
}
