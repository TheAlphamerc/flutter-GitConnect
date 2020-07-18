import 'package:flutter_github_connect/bloc/repo/index.dart';
import 'package:flutter_github_connect/resources/provider/api_gatway.dart';

class RepoRepository {
  final ApiGateway apiGatway ;
  RepoRepository({this.apiGatway}) : assert( apiGatway != null);

  

  Future<List<RepositoryModel>> fetchRepositories(bool isError) async{
    return await apiGatway.fetchRepositories();
  }
}