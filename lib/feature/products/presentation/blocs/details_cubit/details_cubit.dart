import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  StreamSubscription? streamSubscription;

  DetailsCubit() : super(DetailsInitial()) {
    streamSubscription =
        AppSettings().productUpdateStream.stream.listen((event) {
      if (event is AddNewComment) {
        updateComment();
      }
    });
  }
  @override
  Future<void> close() async {
    streamSubscription?.cancel();
    super.close();
  }

  void updateComment() {
    emit(DetailsUpdateCommentLoading());
    emit(DetailsUpdateCommentLoaded());
  }
}
