import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';
import 'package:test_flutter/feature/account/data/models/local/my_identity_model.dart';
import 'package:test_flutter/feature/account/data/models/remote/register_model.dart';
import 'package:test_flutter/feature/account/domain/use_cases/get_my_identity_use_case.dart';
import 'package:test_flutter/feature/account/domain/use_cases/register_use_case.dart';
import 'package:test_flutter/feature/account/domain/use_cases/save_my_identity_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void register(RegisterParamsModel paramsModel) async {
    emit(RegisterLoading());
    final res = await RegisterUseCase().call(paramsModel);
    res.fold((l) => emit(RegisterError(message: l)), (r) async {
      final MyIdentity identity = MyIdentity(
        name: r.modelData?.name,
        token: r.modelData?.token,
      );
      await SaveMyIdentityUseCase().call(identity);
      final res = await GetMyIdentityUseCase().call(NoParams());
      AppSettings().identity = res.fold((l) => null, (r) => r);
      emit(RegisterLoaded(model: r));
    });
  }
}
