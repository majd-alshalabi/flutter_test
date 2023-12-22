import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/search_products_model.dart';
import 'package:test_flutter/feature/products/data/repositories/products_repositories.dart';

class SearchUseCase
    extends UseCase<SearchProductsResponseModel, SearchProductParamsModel> {
  ProductsRepositories repository = ProductsRepositories();

  @override
  Future<Either<String, SearchProductsResponseModel>> call(
    SearchProductParamsModel params,
  ) async {
    return repository.searchProduct(params);
  }
}
