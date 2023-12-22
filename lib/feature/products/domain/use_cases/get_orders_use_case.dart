import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_orders_model.dart';
import 'package:test_flutter/feature/products/data/repositories/products_repositories.dart';

class GetOrdersUseCase extends UseCase<OrderResponseModel, NoParams> {
  ProductsRepositories repository = ProductsRepositories();

  @override
  Future<Either<String, OrderResponseModel>> call(
    NoParams params,
  ) async {
    return repository.getOrders();
  }
}
