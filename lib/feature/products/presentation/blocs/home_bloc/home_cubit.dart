import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';
import 'package:test_flutter/feature/account/domain/use_cases/delete_my_identity_use_case.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_products_model.dart';
import 'package:test_flutter/feature/products/domain/use_cases/get_products_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  StreamSubscription? streamSubscription;

  HomeCubit() : super(HomeInitial()) {
    streamSubscription =
        AppSettings().productUpdateStream.stream.listen((event) {
      if (event is AddNewComment) {
        updateCommentCountForProduct(event.productId);
      }
    });
  }
  @override
  Future<void> close() async {
    streamSubscription?.cancel();
    super.close();
  }

  List<ProductsModel> products = [];

  void logOut() async {
    emit(LogOutLoading());

    final res = await DeleteMyIdentityUseCase().call(NoParams());
    res.fold(
      (l) {
        emit(LogOutError(error: l));
      },
      (r) async {
        AppSettings().identity = null;
        emit(LogOutLoaded());
      },
    );
  }

  void updateCommentCountForProduct(int productId) {
    emit(UpdateCommentCountLoading());
    int index = products.indexWhere((element) => element.id == productId);
    if (index != -1) {
      if (products[index].comments != null) {
        products[index].comments = (products[index].comments!) + 1;
      }
    }
    emit(UpdateCommentCountLoaded());
  }

  void getProducts() async {
    emit(GetProductsLoading());

    final res = await GetProductsUseCase().call(NoParams());
    res.fold(
      (l) {
        emit(GetProductsError(error: l));
      },
      (r) async {
        products.addAll(r.data ?? []);
        emit(GetProductsLoaded());
      },
    );
  }

  void updateList(List<ProductsModel> newProduct) async {
    emit(GetProductsLoading());
    products.clear();
    products.addAll(newProduct);
    emit(GetProductsLoaded());
  }
}
