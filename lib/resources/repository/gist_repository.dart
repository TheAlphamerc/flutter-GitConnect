import 'package:flutter_github_connect/bloc/User/model/gist_model.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';

class GistRepository {
  GistRepository({this.apiGatway}) : assert(apiGatway != null);
  final ApiGateway apiGatway;

  Future<Gists> fetchGistList({String login, String endCursor}) async {
    return await apiGatway.fetchGistList(login: login, endCursor: endCursor);
  }

  Future<GistDetail> getGistDetail(String id) async {
    return await apiGatway.fetchGistDetail(id);
  }
}
