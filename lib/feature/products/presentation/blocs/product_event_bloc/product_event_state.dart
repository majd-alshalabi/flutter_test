part of 'product_event_cubit.dart';

@immutable
abstract class ProductEventState {}

class RateInitial extends ProductEventState {}

class RateProductLoading extends ProductEventState {}

class RateProductLoaded extends ProductEventState {}

class RateProductError extends ProductEventState {
  final String error;

  RateProductError({required this.error});
}

class OrderProductLoading extends ProductEventState {}

class OrderProductLoaded extends ProductEventState {}

class OrderProductError extends ProductEventState {
  final String error;

  OrderProductError({required this.error});
}
