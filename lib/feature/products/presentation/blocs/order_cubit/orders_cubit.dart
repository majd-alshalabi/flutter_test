import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/delete_order_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_orders_model.dart';
import 'package:test_flutter/feature/products/domain/use_cases/delete_order_use_case.dart';
import 'package:test_flutter/feature/products/domain/use_cases/get_orders_use_case.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(DetailsInitial());
  List<OrderModel> orders = [];
  void getOrder() async {
    emit(GetAllOrderLoading());
    final res = await GetOrdersUseCase().call(NoParams());
    res.fold(
      (l) => emit(GetAllOrderError(error: l)),
      (r) {
        orders.clear();
        orders.addAll(r.data ?? []);
        emit(GetAllOrderLoaded());
      },
    );
  }

  void deleteOrder(int productId) async {
    emit(DeleteOrderLoading());
    final res = await DeleteOrderUseCase().call(
      DeleteOrderParamsModel(orderId: productId),
    );
    res.fold(
      (l) => emit(DeleteOrderError(error: l)),
      (r) {
        orders.removeWhere((element) => element.id == productId);
        emit(DeleteOrderLoaded());
      },
    );
  }

  void updateList(List<OrderModel> newOrder) async {
    emit(GetAllOrderLoading());
    orders.clear();
    orders.addAll(newOrder);
    emit(GetAllOrderLoaded());
  }
}
