import 'package:test_flutter/core/services/network/network_configrations.dart';
import 'package:test_flutter/core/services/network/network_interface.dart';
import 'package:test_flutter/core/services/network/network_service.dart';
import 'package:test_flutter/feature/account/data/models/remote/login_model.dart';
import 'package:test_flutter/feature/account/data/models/remote/register_model.dart';

class AccountRemoteDataSource {
  NetworkServices networkServices = NetworkServices();
  Future<RegisterResponseModel> register(
    RegisterParamsModel model,
  ) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: model.toJson(),
        networkPath: NetworkConfigurations.kRegisterPath,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(RegisterResponseModel.fromJson(res));
  }

  Future<LoginResponseModel> login(
    LoginParamsModel model,
  ) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: model.toJson(),
        networkPath: NetworkConfigurations.kLoginPath,
        urlParams: <String, String>{},
      ),
    );
    return Future.value(LoginResponseModel.fromJson(res));
  }
}
