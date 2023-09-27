import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/place.dart';
import '../repositories/base_address_repository.dart';

class GetPlacesUseCase
    implements BaseUseCase<Either<Failure, List<Place>>, String> {
  final BaseAddressRepository baseAddressRepository;

  GetPlacesUseCase(this.baseAddressRepository);
  @override
  Future<Either<Failure, List<Place>>> call(String id) =>
      baseAddressRepository.getPlaces(id);
}
