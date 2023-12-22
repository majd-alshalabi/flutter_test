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
  /// this list will store the product list the use is searching for
  List<ProductsModel> products = [];

  /// this [streamSubscription] is for listening for the event from the stream
  /// in the [AppSettings] class so i can know when the comment count change
  /// so i cant update the comment count in the ui
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

    /// this function is just to update the comment count in the list
    /// when the event from the stream in the [AppSettings] arrived
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

    ///this function will update the rate slider in the ui
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
          /// this event will call the search api and will
          /// return one of two state [SearchError]
          /// when some thing went wrong and
          /// [SearchLoaded] when everything goes will and then
          /// it will add the product to the [products] list
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
