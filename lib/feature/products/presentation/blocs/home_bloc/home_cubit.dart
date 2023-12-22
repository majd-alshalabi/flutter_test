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
  /// this [streamSubscription] is for listening for the event from the stream
  /// in the [AppSettings] class so i can know when the comment count change
  /// so i cant update the comment count in the ui
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

  /// this list the for the product list that come from the api
  List<ProductsModel> products = [];

  /// this function is for logging out from the account
  /// it delete the identity and return one of two state
  /// [LogOutError] if something went wrong
  /// and [LogOutLoaded] when logging out done successfully
  /// when everything goes will it will
  /// delete the identity from the [AppSettings]
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

  /// this function is just to update the comment count in the list
  /// when the event from the stream in the [AppSettings] arrived
  void updateCommentCountForProduct(int productId) {
    emit(UpdateCommentCountLoading());
    int index = products.indexWhere((element) => element.id == productId);
    if (index != -1) {
      if (products[index].comments != null) {
        products[index].comments = (products[index].comments!) + 1;
      }
    }
    emit(UpdateCommentCountLoaded(productId: productId));
  }

  /// this function is for getting all product from the api
  /// it return one of two state
  /// [GetProductsError] when something went wrong
  /// and [GetProductsLoaded] when everything goes will
  /// when the api done successfully it add the product to the [products] list
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

  /// this function is used to update the list in the cubit
  void updateList(List<ProductsModel> newProduct) async {
    emit(GetProductsLoading());
    products.clear();
    products.addAll(newProduct);
    emit(GetProductsLoaded());
  }
}
