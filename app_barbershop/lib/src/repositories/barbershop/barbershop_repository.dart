import 'package:app_barbershop/src/core/fp/either.dart';
import 'package:app_barbershop/src/models/barbershop_model.dart';
import 'package:app_barbershop/src/models/user_model.dart';

import '../../core/exceptions/repository_exception.dart';

abstract interface class BarbershopRepository {
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel userModel);
}
