import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_products_model.dart';
import 'package:test_flutter/feature/products/data/repositories/products_repositories.dart';

class GetProductsUseCase extends UseCase<GetProductsResponseModel, NoParams> {
  ProductsRepositories repository = ProductsRepositories();

  @override
  Future<Either<String, GetProductsResponseModel>> call(
    NoParams params,
  ) async {
    return repository.getProducts();
  }
}
