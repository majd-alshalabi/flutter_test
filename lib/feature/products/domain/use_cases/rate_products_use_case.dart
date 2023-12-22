import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/rate_products_model.dart';
import 'package:test_flutter/feature/products/data/repositories/products_repositories.dart';

class RateProductsUseCase
    extends UseCase<RateProductsResponseModel, RateProductParamsModel> {
  ProductsRepositories repository = ProductsRepositories();

  @override
  Future<Either<String, RateProductsResponseModel>> call(
    RateProductParamsModel params,
  ) async {
    return repository.rateProduct(params);
  }
}
