part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {}

class SearchError extends SearchState {
  final String error;

  SearchError({required this.error});
}

class UpdateRateLoading extends SearchState {}

class UpdateRateLoaded extends SearchState {}

class UpdateCommentCountInSearchLoading extends SearchState {}

class UpdateCommentCountInSearchLoaded extends SearchState {
  final int productId;

  UpdateCommentCountInSearchLoaded({required this.productId});
}
