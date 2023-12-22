import 'package:dartz/dartz.dart';
import 'package:test_flutter/feature/products/data/models/remote/delete_order_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_orders_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/order_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/rate_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/search_products_model.dart';

abstract class IProductsRepository {
  Future<Either<String, GetProductsResponseModel>> getProducts();
  Future<Either<String, RateProductsResponseModel>> rateProduct(
    RateProductParamsModel params,
  );
  Future<Either<String, OrderProductsResponseModel>> orderProduct(
    OrderProductParamsModel params,
  );
  Future<Either<String, OrderResponseModel>> getOrders();
  Future<Either<String, DeleteOrderResponseModel>> deleteOrder(
    DeleteOrderParamsModel params,
  );
  Future<Either<String, SearchProductsResponseModel>> searchProduct(
    SearchProductParamsModel params,
  );
}
