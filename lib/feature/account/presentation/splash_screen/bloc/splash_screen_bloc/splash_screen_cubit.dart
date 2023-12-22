import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/constants/enums.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';
import 'package:test_flutter/feature/account/domain/use_cases/get_my_identity_use_case.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(SplashScreenInitial());

  void initState() async {
    emit(SplashScreenLoading());

    ToWhereShouldINavigateFromSplash toWhere =
        ToWhereShouldINavigateFromSplash.signInPage;
    final res = await GetMyIdentityUseCase().call(NoParams());
    res.fold((l) => emit(SplashScreenError(error: l)), (r) async {
      if (r != null) {
        AppSettings().identity = r;
        toWhere = ToWhereShouldINavigateFromSplash.home;
      }
      emit(SplashScreenLoaded(toWhere: toWhere));
    });
  }
}
