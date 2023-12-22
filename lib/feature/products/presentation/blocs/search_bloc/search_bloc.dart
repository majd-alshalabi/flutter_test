import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';
import 'package:test_flutter/feature/products/data/models/remote/get_products_model.dart';
import 'package:test_flutter/feature/products/data/models/remote/search_products_model.dart';
import 'package:test_flutter/feature/products/domain/use_cases/search_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<ProductsModel> products = [];
  StreamSubscription? streamSubscription;
  double? rate;
  @override
  Future<void> close() async {
    streamSubscription?.cancel();
    super.close();
  }

  SearchBloc() : super(SearchInitial()) {
    streamSubscription =
        AppSettings().productUpdateStream.stream.listen((event) {
      if (event is AddNewComment) {
        add(UpdateCommentCount(productId: event.productId));
      }
    });
    on<UpdateCommentCount>(
      (event, emit) {
        emit(UpdateCommentCountInSearchLoading());
        int index =
            products.indexWhere((element) => element.id == event.productId);
        if (index != -1) {
          if (products[index].comments != null) {
            products[index].comments = products[index].comments! + 1;
          } else {
            products[index].comments = 1;
          }
        }
        emit(UpdateCommentCountInSearchLoaded(productId: event.productId));
      },
    );
    on<UpdateRate>(
      (event, emit) {
        emit(UpdateRateLoading());
        rate = event.rate;
        emit(UpdateRateLoaded());
      },
    );
    on<SearchEvent>(
      (event, emit) async {
        switch (event.runtimeType) {
          case NewSearchEvents:
            event as NewSearchEvents;
            emit(SearchLoading());
            final result = await SearchUseCase().call(SearchProductParamsModel(
              rate: rate,
              title: event.name,
            ));
            result.fold(
              (l) => emit(SearchError(error: l)),
              (r) {
                products.clear();
                products.addAll(r.data ?? []);
                emit(SearchLoaded());
              },
            );
            break;
        }
      },
      transformer: restartable(),
    );
  }
}
