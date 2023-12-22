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

  /// this list will store the user order list
  List<OrderModel> orders = [];

  /// this function will get the user order bu call the api
  /// and when every thing goes will it will return one of two state
  /// [GetAllOrderError] when something when wrong
  /// and [GetAllOrderLoaded] when every thing is good
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

  /// this function will delete a order by calling the api
  /// when every thing goes will it will return
  /// [DeleteOrderLoaded] and delete the order from the list
  /// otherwise it will return [DeleteOrderError]
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

  /// this function is just to update the order list
  void updateList(List<OrderModel> newOrder) async {
    emit(GetAllOrderLoading());
    orders.clear();
    orders.addAll(newOrder);
    emit(GetAllOrderLoaded());
  }
}
