import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_notification_repository.dart';

class GetUnReadNotificationUseCase
    implements BaseUseCase<Either<Failure, String>, NoParameters> {
  final BaseNotificationRepository baseNotificationRepository;

  GetUnReadNotificationUseCase(this.baseNotificationRepository);
  @override
  Future<Either<Failure, String>> call(_) =>
      baseNotificationRepository.getUnReadNotificationNum();
}
