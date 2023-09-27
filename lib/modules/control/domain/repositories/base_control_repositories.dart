import 'package:dartz/dartz.dart';

import '../../../../app/errors/failure.dart';
import '../entities/contact_info.dart';

abstract class BaseControlRepository {
  Future<Either<Failure, ContactInfo>> getContactInfo();
}
