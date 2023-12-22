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

  /// this list will store the comment that the api
  /// will get and the comment that the use will add
  List<CommentModel> comments = [];

  /// this function accent [productId]
  /// this id will be sent to the api so we can get the
  /// comment from the backend
  /// this function return two state
  /// [GetCommentError] when something went wrong
  /// and [GetCommentLoaded] when every thing goes right
  /// and when the api call is done successfully its store the
  /// comment in the [comments] list so we can access it from the screen
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

  /// this function accept the string [comment] and the [productId]
  /// the user commenting at
  /// this function call the add comment api
  /// and return two state
  /// [AddCommentError] when something went wrong
  /// and [AddCommentLoaded] when everything goes well
  /// and when the api call is done successfully
  /// it add an event to stream in the [AppSettings] class
  /// so i can update the comment count in other cubit or blocs
  /// and then add the comment to the comment list [comments]
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
