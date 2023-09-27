import '../../domain/entities/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel(
      {required String id,
      required String pageType,
      required String url,
      required String status,
      required String dateAdded,
      required String image,
      required String title,
      required String content})
      : super(
          id: id,
          pageType: pageType,
          url: url,
          status: status,
          dateAdded: dateAdded,
          image: image,
          title: title,
          content: content,
        );
  factory NotificationModel.fromJson(Map<String, dynamic> map) =>
      NotificationModel(
        id: map['id'],
        content: map['content'] ?? map['admin_notification_content'] ?? '',
        image: map['image'] ?? '',
        pageType: map['page_type'] ?? '',
        url: map['url'] ?? '',
        status: map['status'] ?? '0',
        title: map['title'] ?? map['admin_notification_title'] ?? '',
        dateAdded: map['date_added'] ?? '',
      );
}
