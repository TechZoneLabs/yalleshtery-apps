import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../repositories/base_cart_repository.dart';

class DeletePromoUseCase
    implements BaseUseCase<Either<Failure, bool>, String> {
  final BaseCartRepository baseCartRepository;

  DeletePromoUseCase(this.baseCartRepository);
  @override
  Future<Either<Failure, bool>> call(String id) =>
      baseCartRepository.deletePromoCode(id);
}