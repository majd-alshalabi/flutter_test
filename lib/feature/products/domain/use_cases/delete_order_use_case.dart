import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/delete_order_model.dart';
import 'package:test_flutter/feature/products/data/repositories/products_repositories.dart';

class DeleteOrderUseCase
    extends UseCase<DeleteOrderResponseModel, DeleteOrderParamsModel> {
  ProductsRepositories repository = ProductsRepositories();

  @override
  Future<Either<String, DeleteOrderResponseModel>> call(
    DeleteOrderParamsModel params,
  ) async {
    return repository.deleteOrder(params);
  }
}
