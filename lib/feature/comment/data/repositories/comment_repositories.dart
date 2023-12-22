import 'package:dartz/dartz.dart';
import 'package:test_flutter/feature/comment/data/data_sources/remote/comment_remote_data_source.dart';
import 'package:test_flutter/feature/comment/data/models/remote/add_comment_model.dart';
import 'package:test_flutter/feature/comment/data/models/remote/comment_model.dart';
import 'package:test_flutter/feature/comment/domain/repositories/icomment_repository.dart';

class CommentRepositories implements ICommentRepository {
  final CommentRemoteDataSource commentRemoteDataSource =
      CommentRemoteDataSource();
  @override
  Future<Either<String, GetCommentResponseModel>> getComment(
      GetCommentParamsModel params) async {
    try {
      final GetCommentResponseModel res =
          await commentRemoteDataSource.getComment(params);
      return Right(res);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AddCommentResponseModel>> addComment(
    AddCommentParamsModel params,
  ) async {
    try {
      final AddCommentResponseModel res =
          await commentRemoteDataSource.addComment(params);
      return Right(res);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
