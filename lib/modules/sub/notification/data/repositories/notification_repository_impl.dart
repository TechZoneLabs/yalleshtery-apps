import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

import '/app/services/network_services.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/base_notification_repository.dart';
import '../datasources/remote_data_source.dart';

class NotificationRepositoryImpl implements BaseNotificationRepository {
  final BaseNotificationRemoteDataSource baseNotificaionRemoteDataSource;
  final NetworkServices networkServices;

  NotificationRepositoryImpl(
    this.baseNotificaionRemoteDataSource,
    this.networkServices,
  );

  @override
  Future<Either<Failure, List<Notification>>> getNotificationsList(
      int start) async {
    if (await networkServices.isConnected()) {
      try {
        final notificationResponse =
            await baseNotificaionRemoteDataSource.getNotificationsList(start);
        if (notificationResponse.success) {
          return Right(notificationResponse.notList);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNotification(String id) async {
    if (await networkServices.isConnected()) {
      try {
        final val =
            await baseNotificaionRemoteDataSource.deleteNotification(id);
        if (val) {
          return const Right(true);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, Notification>> getNotificationDetails(
      String id) async {
    if (await networkServices.isConnected()) {
      try {
        final notificationResponse =
            await baseNotificaionRemoteDataSource.getNotificationDetails(id);
        if (notificationResponse.success) {
          return Right(notificationResponse.notificationDetails!);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, String>> getUnReadNotificationNum() async {
    if (await networkServices.isConnected()) {
      try {
        final val =
            await baseNotificaionRemoteDataSource.getUnReadNotificationNum();
        return Right(val);
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }

  @override
  Future<Either<Failure, bool>> readNotification(String id) async {
    if (await networkServices.isConnected()) {
      try {
        final val = await baseNotificaionRemoteDataSource.readNotification(id);
        if (val) {
          return const Right(true);
        } else {
          return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
        }
      } on ServerExecption catch (_) {
        return Left(ServerFailure(msg: AppStrings.tryAgain.tr()));
      }
    } else {
      return Left(ServerFailure(msg: AppStrings.noInternet.tr()));
    }
  }
}
