import 'package:dartz/dartz.dart';
import 'package:test_flutter/core/models/user_case_model.dart';
import 'package:test_flutter/feature/comment/data/models/remote/add_comment_model.dart';
import 'package:test_flutter/feature/comment/data/repositories/comment_repositories.dart';

class AddCommentUseCase
    extends UseCase<AddCommentResponseModel, AddCommentParamsModel> {
  CommentRepositories repository = CommentRepositories();

  @override
  Future<Either<String, AddCommentResponseModel>> call(
    AddCommentParamsModel params,
  ) async {
    return repository.addComment(params);
  }
}
