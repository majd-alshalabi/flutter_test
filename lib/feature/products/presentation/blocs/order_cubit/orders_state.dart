part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class DetailsInitial extends OrdersState {}

class GetAllOrderLoading extends OrdersState {}

class GetAllOrderLoaded extends OrdersState {}

class GetAllOrderError extends OrdersState {
  final String error;

  GetAllOrderError({required this.error});
}

class DeleteOrderLoading extends OrdersState {}

class DeleteOrderLoaded extends OrdersState {}

class DeleteOrderError extends OrdersState {
  final String error;

  DeleteOrderError({required this.error});
}
