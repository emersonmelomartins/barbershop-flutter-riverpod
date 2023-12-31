import 'dart:developer';
import 'dart:io';

import 'package:app_barbershop/src/core/exceptions/auth_exception.dart';
import 'package:app_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:app_barbershop/src/core/fp/either.dart';
import 'package:app_barbershop/src/core/restClient/rest_client.dart';
import 'package:app_barbershop/src/models/user_model.dart';
import 'package:app_barbershop/src/repositories/user/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;
  UserRepositoryImpl({required this.restClient});

  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unauth.post("/auth", data: {
        "email": email,
        "password": password,
      });

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log("Login ou senha inválidos", error: e, stackTrace: s);
          return Failure(AuthUnauthorizedError());
        }
      }

      log("Erro ao realizar login", error: e, stackTrace: s);
      return Failure(AuthError(message: "Erro ao realizar login"));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get("/me");
      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log("Erro ao buscar usuário logado", error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: "Erro ao buscar usuário logado"));
    } on ArgumentError catch (e, s) {
      log("Json Inválido", error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }
}
