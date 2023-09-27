import 'package:dartz/dartz.dart';

import '../../../../../app/errors/failure.dart';
import '../entities/notification.dart';

abstract class BaseNotificationRepository {
  Future<Either<Failure, List<Notification>>> getNotificationsList(int start);
  Future<Either<Failure, String>> getUnReadNotificationNum();
  Future<Either<Failure, bool>> deleteNotification(String id);
  Future<Either<Failure, bool>> readNotification(String id);
  Future<Either<Failure, Notification>> getNotificationDetails(String id);
}
