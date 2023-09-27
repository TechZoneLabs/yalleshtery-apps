import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/address.dart';
import '../repositories/base_address_repository.dart';

class AddAddressUseCase
    implements BaseUseCase<Either<Failure,bool>, Address > {
  final BaseAddressRepository baseAddressRepository;

  AddAddressUseCase(this.baseAddressRepository);
  @override
  Future<Either<Failure,bool>> call(Address address) => baseAddressRepository.addAddress(address);
}
