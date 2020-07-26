import 'package:flutter_github_connect/bloc/User/User_model.dart';
import 'package:flutter_github_connect/bloc/User/model/event_model.dart';
import 'package:flutter_github_connect/resources/provider/api_gatway.dart';
class UserRepository {
  final ApiGateway apiGatway ;
  UserRepository({this.apiGatway}) : assert( apiGatway != null);

  Future<UserModel> fetchUserProfile() async{
    return await apiGatway.fetchUserProfile();
  }
  Future<List<EventModel>> fetchUserEvent() async{
    return await apiGatway.fetchUserEvent();
  }
}