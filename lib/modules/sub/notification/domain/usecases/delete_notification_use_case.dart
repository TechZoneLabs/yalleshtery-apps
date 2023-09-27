import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_notification_repository.dart';

class DeleteNotificationUseCase
    implements BaseUseCase<Either<Failure, bool>, String> {
  final BaseNotificationRepository baseNotificationRepository;

  DeleteNotificationUseCase(this.baseNotificationRepository);
  @override
  Future<Either<Failure, bool>> call(String parameter) =>
      baseNotificationRepository.deleteNotification(parameter);
}
