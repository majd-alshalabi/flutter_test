import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/account/data/models/remote/login_model.dart';
import 'package:test_flutter/feature/account/data/repositories/account_repositories.dart';

class LoginUseCase extends UseCase<LoginResponseModel, LoginParamsModel> {
  AccountRepositories repository = AccountRepositories();

  @override
  Future<Either<String, LoginResponseModel>> call(
    LoginParamsModel params,
  ) async {
    return repository.login(params);
  }
}
