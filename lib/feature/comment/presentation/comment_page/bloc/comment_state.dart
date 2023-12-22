part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class GetCommentLoading extends CommentState {}

class GetCommentLoaded extends CommentState {}

class GetCommentError extends CommentState {
  final String error;

  GetCommentError({required this.error});
}

class AddCommentLoading extends CommentState {}

class AddCommentLoaded extends CommentState {}

class AddCommentError extends CommentState {
  final String error;

  AddCommentError({required this.error});
}
