import 'package:test_flutter/core/services/network/network_configrations.dart';
import 'package:test_flutter/core/services/network/network_interface.dart';
import 'package:test_flutter/core/services/network/network_service.dart';
import 'package:test_flutter/feature/comment/data/models/remote/add_comment_model.dart';
import 'package:test_flutter/feature/comment/data/models/remote/comment_model.dart';

class CommentRemoteDataSource {
  NetworkServices networkServices = NetworkServices();
  Future<GetCommentResponseModel> getComment(
    GetCommentParamsModel params,
  ) async {
    final res = await networkServices.get(
      RemoteDataBundle(
        body: {},
        networkPath: NetworkConfigurations.kGetComments,
        urlParams: params.toJson(),
      ),
    );
    return Future.value(GetCommentResponseModel.fromJson(res));
  }

  Future<AddCommentResponseModel> addComment(
    AddCommentParamsModel params,
  ) async {
    final res = await networkServices.post(
      RemoteDataBundle(
        body: params.toJson(),
        networkPath: NetworkConfigurations.kGetComments,
        urlParams: {},
      ),
    );
    return Future.value(AddCommentResponseModel.fromJson(res));
  }
}
