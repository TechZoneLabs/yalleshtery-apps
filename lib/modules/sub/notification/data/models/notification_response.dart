import 'notification_model.dart';

class NotificationResponse {
  final bool success;
  final List<NotificationModel> notList;
  final NotificationModel? notificationDetails;

  NotificationResponse({
    required this.success,
    this.notList = const [],
    this.notificationDetails,
  });
  factory NotificationResponse.fromJson(Map<String, dynamic> map) {
    bool containData = map.containsKey('data');
    bool dataHasList = containData ? map['data'] is List : false;
    return dataHasList
        ? NotificationResponse(
            success: map['success'],
            notList: (map['data'] as List)
                .map((e) => NotificationModel.fromJson(e))
                .toList(),
          )
        : NotificationResponse(
            success: map['success'],
            notificationDetails:
                containData ? NotificationModel.fromJson(map['data']) : null,
          );
  }
}
