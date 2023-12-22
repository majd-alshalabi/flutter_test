import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/account/data/models/local/my_identity_model.dart';
import 'package:test_flutter/feature/account/data/repositories/account_repositories.dart';

class GetMyIdentityUseCase extends UseCase<MyIdentity?, NoParams> {
  AccountRepositories repository = AccountRepositories();

  @override
  Future<Either<String, MyIdentity?>> call(NoParams params) async {
    return await repository.getMyIdentity();
  }
}
