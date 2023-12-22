import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/order_products_model.dart';
import 'package:test_flutter/feature/products/data/repositories/products_repositories.dart';

class OrderProductsUseCase
    extends UseCase<OrderProductsResponseModel, OrderProductParamsModel> {
  ProductsRepositories repository = ProductsRepositories();

  @override
  Future<Either<String, OrderProductsResponseModel>> call(
    OrderProductParamsModel params,
  ) async {
    return repository.orderProduct(params);
  }
}
