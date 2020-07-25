import 'package:flutter_github_connect/bloc/issues/index.dart';
import 'package:flutter_github_connect/resources/provider/api_gatway.dart';

class IssuesRepository {
  IssuesRepository({this.apiGatway}) : assert(apiGatway != null);
  final ApiGateway apiGatway;

  Future<List<IssuesModel>> getIssues() async {
    return await apiGatway.fetchIssues();
  }
}
