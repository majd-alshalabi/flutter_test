import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/core/services/app_settings/app_settings.dart';
import 'package:test_flutter/core/utils/utils.dart';
import 'package:test_flutter/feature/comment/data/models/remote/add_comment_model.dart';
import 'package:test_flutter/feature/comment/data/models/remote/comment_model.dart';
import 'package:test_flutter/feature/comment/domain/use_cases/add_comment_use_case.dart';
import 'package:test_flutter/feature/comment/domain/use_cases/get_comment_use_case.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());
  List<CommentModel> comments = [];
  void getComment(int productId) async {
    emit(GetCommentLoading());

    final result = await GetCommentsUseCase().call(
      GetCommentParamsModel(productId: productId),
    );
    result.fold(
      (l) => emit(GetCommentError(error: l)),
      (r) {
        comments.addAll(r.data ?? []);
        emit(GetCommentLoaded());
      },
    );
  }

  void addComment({required String comment, required int productId}) async {
    emit(AddCommentLoading());

    final result = await AddCommentUseCase().call(
      AddCommentParamsModel(productId: productId, content: comment),
    );
    result.fold(
      (l) => emit(AddCommentError(error: l)),
      (r) {
        comments.insert(
          0,
          CommentModel(
            content: comment,
            createdAt: Utils.dateToUtcFormatted(DateTime.now()),
          ),
        );
        AppSettings().productUpdateStream.add(
              AddNewComment(productId: productId),
            );
        emit(AddCommentLoaded());
      },
    );
  }

  void updateCommentList(List<CommentModel> newComments) async {
    emit(GetCommentLoading());
    comments.clear();
    comments.addAll(comments);
    emit(GetCommentLoaded());
  }
}
