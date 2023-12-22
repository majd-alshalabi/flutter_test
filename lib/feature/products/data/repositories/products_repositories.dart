import 'package:dartz/dartz.dart';
import 'package:test_flutter/feature/products/data/data_sources/remote/products_remote_data_source.dart';
import 'package:test_flutter/feature/products/data/models/remote/delete_order_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_orders_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/order_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/rate_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/search_products_model.dart';
import 'package:test_flutter/feature/products/domain/repositories/iProducts_repository.dart';

class ProductsRepositories implements IProductsRepository {
  final HomeRemoteDataSource homeRemoteDataSource = HomeRemoteDataSource();
  @override
  Future<Either<String, GetProductsResponseModel>> getProducts() async {
    try {
      final GetProductsResponseModel res =
          await homeRemoteDataSource.getProduct();
      return Right(res);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, SearchProductsResponseModel>> searchProduct(
    SearchProductParamsModel params,
  ) async {
    try {
      final SearchProductsResponseModel res =
          await homeRemoteDataSource.searchProduct(params);
      return Right(res);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, OrderResponseModel>> getOrders() async {
    try {
      final OrderResponseModel res = await homeRemoteDataSource.getOrder();
      return Right(res);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, RateProductsResponseModel>> rateProduct(
    RateProductParamsModel params,
  ) async {
    try {
      final RateProductsResponseModel res =
          await homeRemoteDataSource.rateProduct(params);
      return Right(res);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, OrderProductsResponseModel>> orderProduct(
    OrderProductParamsModel params,
  ) async {
    try {
      final OrderProductsResponseModel res =
          await homeRemoteDataSource.orderProduct(params);
      return Right(res);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DeleteOrderResponseModel>> deleteOrder(
    DeleteOrderParamsModel params,
  ) async {
    try {
      final DeleteOrderResponseModel res =
          await homeRemoteDataSource.deleteOrder(params);
      return Right(res);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
