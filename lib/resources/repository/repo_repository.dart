import 'package:flutter_github_connect/bloc/commit/commit_model.dart' as commit;
import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/bloc/bloc/repo_response_model.dart';
import 'package:flutter_github_connect/model/forks_model.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';
import 'package:flutter_github_connect/bloc/search/model/search_userModel.dart'
    as model;

class SearchRepository {
  final ApiGateway apiGatway;
  SearchRepository({this.apiGatway}) : assert(apiGatway != null);

  Future<model.Search> searchQuery(
      {GithubSearchType type, String query,String endCursor}) async {
    assert(type != null, query != null);
    return await apiGatway.searchQuery(type: type, query: query,endCursor:endCursor);
  }
}

class RepoRepository {
  final ApiGateway apiGatway;
  RepoRepository({this.apiGatway}) : assert(apiGatway != null);

  Future<RepositoryModel> getRepository({String name, String owner}) async {
    assert(name != null, owner != null);
    return await apiGatway.fetchRepository(name: name, owner: owner);
  }

  Future<String> getReadme({String name, String owner}) async {
    assert(name != null, owner != null);
    return await apiGatway.fetchReadme(name: name, owner: owner);
  }
  Future<ForksModel> fetchRepoForks({String name, String owner,String endCursor}) async {
    assert(name != null, owner != null);
    return await apiGatway.fetchRepoForks(name: name, owner: owner,endCursor:endCursor);
  }
  Future<commit.History> fetchCommits({String name, String owner,String endCursor}) async {
    assert(name != null, owner != null);
    return await apiGatway.fetchCommits(name: name, owner: owner,endCursor:endCursor);
  }
}
