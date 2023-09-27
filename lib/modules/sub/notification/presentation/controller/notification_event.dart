part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationsEvent extends NotificationEvent {
  final int start;
  const GetNotificationsEvent({this.start = 0});
}

class GetUnReadNotificationEvent extends NotificationEvent {}

class DeleteNotificationEvent extends NotificationEvent {
  final String id;
  const DeleteNotificationEvent({required this.id});
}

class ReadNotificationEvent extends NotificationEvent {
  final String id;
  const ReadNotificationEvent({required this.id});
}

class GetNotificationDetailsEvent extends NotificationEvent {
  final String id;
  const GetNotificationDetailsEvent({required this.id});
}
