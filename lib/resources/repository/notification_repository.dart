import 'package:flutter_github_connect/bloc/notification/notification_model.dart';
import 'package:flutter_github_connect/resources/gatway/api_gatway.dart';

class NotificationRepository {
  final ApiGateway apiGatway;
  NotificationRepository({this.apiGatway}) : assert(apiGatway != null);

  Future<List<NotificationModel>> getNotificationsList() async {
    List<NotificationModel> list = await apiGatway.fetchNotificationList();
    return list;
  }
}
