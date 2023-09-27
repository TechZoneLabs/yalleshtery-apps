import 'package:dartz/dartz.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../entities/slider_banner.dart';
import '../repositories/base_home_repository.dart';

class GetSliderBannersUseCase
    implements BaseUseCase<Either<Failure, List<SliderBanner>>, NoParameters> {
  final BaseHomeRepository baseHomeRepository;

  GetSliderBannersUseCase(this.baseHomeRepository);
  @override
  Future<Either<Failure, List<SliderBanner>>> call(_) =>
      baseHomeRepository.getSliderBanners();
}
