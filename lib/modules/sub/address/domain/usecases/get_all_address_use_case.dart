import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/address.dart';
import '../repositories/base_address_repository.dart';

class GetAllAddressesUseCase
    implements BaseUseCase<Either<Failure, List<Address>>, int > {
  final BaseAddressRepository baseAddressRepository;

  GetAllAddressesUseCase(this.baseAddressRepository);
  @override
  Future<Either<Failure, List<Address>>> call(int start) => baseAddressRepository.getAllAddresses(start);
}
