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
