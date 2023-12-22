import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/account/data/models/remote/register_model.dart';
import 'package:test_flutter/feature/account/data/repositories/account_repositories.dart';

class RegisterUseCase
    extends UseCase<RegisterResponseModel, RegisterParamsModel> {
  AccountRepositories repository = AccountRepositories();

  @override
  Future<Either<String, RegisterResponseModel>> call(
    RegisterParamsModel params,
  ) async {
    return repository.register(params);
  }
}
