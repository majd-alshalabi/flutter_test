import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/comment/data/models/remote/comment_model.dart';
import 'package:test_flutter/feature/comment/data/repositories/comment_repositories.dart';

class GetCommentsUseCase
    extends UseCase<GetCommentResponseModel, GetCommentParamsModel> {
  CommentRepositories repository = CommentRepositories();

  @override
  Future<Either<String, GetCommentResponseModel>> call(
    GetCommentParamsModel params,
  ) async {
    return repository.getComment(params);
  }
}
