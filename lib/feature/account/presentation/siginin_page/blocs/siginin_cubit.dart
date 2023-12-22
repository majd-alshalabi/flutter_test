import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';
import 'package:test_flutter/feature/account/data/models/local/my_identity_model.dart';
import 'package:test_flutter/feature/account/data/models/remote/login_model.dart';
import 'package:test_flutter/feature/account/domain/use_cases/get_my_identity_use_case.dart';
import 'package:test_flutter/feature/account/domain/use_cases/login_use_case.dart';
import 'package:test_flutter/feature/account/domain/use_cases/save_my_identity_use_case.dart';

part 'siginin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  /// this function is for login in it accept [LoginParamsModel]
  /// which contain the login data and return a state base on the api
  /// response [LoginLoaded] if login done successfully
  /// [LoginError] if something went wrong
  /// when api call done successfully this function store
  /// the user data and token in sqflite database
  /// and in the [AppSettings] class so it can be access instantly
  void login(LoginParamsModel paramsModel) async {
    emit(LoginLoading());
    final res = await LoginUseCase().call(paramsModel);
    res.fold((l) {
      emit(LoginError(l));
    }, (r) async {
      MyIdentity identity = MyIdentity(
        name: r.modelData?.name,
        token: r.modelData?.token,
      );
      await SaveMyIdentityUseCase().call(identity);
      final res = await GetMyIdentityUseCase().call(NoParams());
      AppSettings().identity = res.fold((l) => null, (r) => r);
      emit(LoginLoaded(model: r));
    });
  }
}
