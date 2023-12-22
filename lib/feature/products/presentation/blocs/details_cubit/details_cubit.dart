import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  /// this [streamSubscription] is for listening for the event from the stream
  /// in the [AppSettings] class so i can know when the comment count change
  /// so i cant update the comment count in the ui
  StreamSubscription? streamSubscription;

  DetailsCubit() : super(DetailsInitial()) {
    streamSubscription =
        AppSettings().productUpdateStream.stream.listen((event) {
      if (event is AddNewComment) {
        updateComment(event.productId);
      }
    });
  }
  @override
  Future<void> close() async {
    streamSubscription?.cancel();
    super.close();
  }

  /// this function is just for updating the state
  void updateComment(int productId) {
    emit(DetailsUpdateCommentLoading());
    emit(DetailsUpdateCommentLoaded(productId: productId));
  }
}
