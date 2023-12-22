import 'package:dartz/dartz.dart';
import 'package:test_flutter/feature/comment/data/models/remote/add_comment_model.dart';
import 'package:test_flutter/feature/comment/data/models/remote/comment_model.dart';

abstract class ICommentRepository {
  Future<Either<String, GetCommentResponseModel>> getComment(
    GetCommentParamsModel params,
  );
  Future<Either<String, AddCommentResponseModel>> addComment(
    AddCommentParamsModel params,
  );
}
