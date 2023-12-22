import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/feature/products/data/models/remote/order_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/rate_products_model.dart';
import 'package:test_flutter/feature/products/domain/use_cases/order_products_use_case.dart';
import 'package:test_flutter/feature/products/domain/use_cases/rate_products_use_case.dart';

part 'product_event_state.dart';

class ProductEventCubit extends Cubit<ProductEventState> {
  ProductEventCubit() : super(RateInitial());

  void rateProduct({required int productId, required double rate}) async {
    emit(RateProductLoading());

    final res = await RateProductsUseCase()
        .call(RateProductParamsModel(rate: rate, productId: productId));
    res.fold(
      (l) {
        emit(RateProductError(error: l));
      },
      (r) async {
        emit(RateProductLoaded());
      },
    );
  }

  void orderProduct({required int productId}) async {
    emit(OrderProductLoading());

    final res = await OrderProductsUseCase()
        .call(OrderProductParamsModel(productId: productId));
    res.fold(
      (l) {
        emit(OrderProductError(error: l));
      },
      (r) async {
        emit(OrderProductLoaded());
      },
    );
  }
}
