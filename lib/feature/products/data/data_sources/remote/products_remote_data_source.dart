import 'package:test_flutter/core/services/network/network_configrations.dart';
import 'package:test_flutter/core/services/network/network_interface.dart';
import 'package:test_flutter/core/services/network/network_service.dart';
import 'package:test_flutter/feature/products/data/models/remote/delete_order_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_orders_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/order_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/rate_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/search_products_model.dart';

class HomeRemoteDataSource {
  NetworkServices networkServices = NetworkServices();
  Future<GetProductsResponseModel> getProduct() async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: {},
        networkPath: NetworkConfigurations.kGetProducts,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(GetProductsResponseModel.fromJson(res));
  }

  Future<SearchProductsResponseModel> searchProduct(
      SearchProductParamsModel params) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kFilterProduct,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(SearchProductsResponseModel.fromJson(res));
  }

  Future<OrderResponseModel> getOrder() async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: {},
        networkPath: NetworkConfigurations.kOrderProduct,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(OrderResponseModel.fromJson(res));
  }

  Future<RateProductsResponseModel> rateProduct(
    RateProductParamsModel params,
  ) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kRateProduct,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(RateProductsResponseModel.fromJson(res));
  }

  Future<OrderProductsResponseModel> orderProduct(
    OrderProductParamsModel params,
  ) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kOrderProduct,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(OrderProductsResponseModel.fromJson(res));
  }

  Future<DeleteOrderResponseModel> deleteOrder(
    DeleteOrderParamsModel params,
  ) async {
    final res = await networkServices.delete(
      RemoteDataBundle(
        body: {},
        networkPath: "${NetworkConfigurations.kOrderProduct}/${params.orderId}",
        urlParams: {},
      ),
    );
    return Future.value(DeleteOrderResponseModel.fromJson(res));
  }
}
