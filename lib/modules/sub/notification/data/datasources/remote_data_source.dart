import '../../../../../app/services/api_services.dart';

import '../../../../../app/errors/exception.dart';
import '../models/notification_response.dart';

abstract class BaseNotificationRemoteDataSource {
  Future<NotificationResponse> getNotificationsList(int start);
  Future<String> getUnReadNotificationNum();
  Future<bool> deleteNotification(String id);
  Future<bool> readNotification(String id);
  Future<NotificationResponse> getNotificationDetails(String id);
}

class NotificationRemoteDataSource implements BaseNotificationRemoteDataSource {
  final ApiServices apiServices;

  NotificationRemoteDataSource(this.apiServices);
  @override
  Future<NotificationResponse> getNotificationsList(int start) async {
    try {
      var map = await apiServices.get(
        file: 'notifications.php',
        action: 'getNotificationsList&start=$start&aItemsPerPage=10',
      );
      return NotificationResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<String> getUnReadNotificationNum() async {
    try {
      var map = await apiServices.get(
        file: 'notifications.php',
        action: 'getUnReadNotificationNum',
      );
      return map['success'] ? map['data'] : '0';
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<bool> deleteNotification(String id) async {
    try {
      var map = await apiServices.post(
        file: 'notifications.php',
        action: 'deleteNotification',
        body: {
          "notification_id": id,
        },
      );
      return map['success'];
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<bool> readNotification(String id) async {
    try {
      var map = await apiServices.post(
        file: 'notifications.php',
        action: 'readNotification',
        body: {
          "notification_id": id,
        },
      );
      return map['success'];
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
  
  @override
  Future<NotificationResponse> getNotificationDetails(String id)async {
     try {
      var map = await apiServices.get(
        file: 'notifications.php',
        action: 'getNotificationDetails&notification_id=$id',
      );
      return NotificationResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
