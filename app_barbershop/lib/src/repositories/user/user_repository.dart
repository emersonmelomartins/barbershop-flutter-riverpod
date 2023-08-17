import 'package:app_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:app_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:app_barbershop/src/core/fp/either.dart';
import 'package:app_barbershop/src/models/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> me();
}
