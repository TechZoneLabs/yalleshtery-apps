import 'package:dartz/dartz.dart';

import '../../../../../app/errors/failure.dart';
import '../entities/page.dart';

abstract class BaseProfileRepository {
  Future<Either<Failure, List<PageEntity>>> getPages();
  Future<Either<Failure, PageEntity>> getPageById(String id);
}
