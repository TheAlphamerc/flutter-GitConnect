import 'package:flutter_github_connect/bloc/search/index.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';

class SearchRepository {
  final ApiGateway apiGatway ;
  SearchRepository({this.apiGatway}) : assert( apiGatway != null);

  Future<List<dynamic>> searchQuery({GithubSearchType type, String query}) async{
    assert(type != null, query != null);
    return await apiGatway.searchQuery(type:type,query:query);
  }

}