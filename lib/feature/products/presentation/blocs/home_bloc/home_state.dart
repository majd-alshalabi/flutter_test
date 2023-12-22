part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LogOutLoading extends HomeState {}

class LogOutLoaded extends HomeState {}

class LogOutError extends HomeState {
  final String error;

  LogOutError({required this.error});
}

class GetProductsLoading extends HomeState {}

class GetProductsLoaded extends HomeState {}

class GetProductsError extends HomeState {
  final String error;

  GetProductsError({required this.error});
}

class UpdateCommentCountLoading extends HomeState {}

class UpdateCommentCountLoaded extends HomeState {
  final int productId;

  UpdateCommentCountLoaded({required this.productId});
}
