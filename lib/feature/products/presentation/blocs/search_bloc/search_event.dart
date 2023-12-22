part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class NewSearchEvents extends SearchEvent {
  final String? name;
  NewSearchEvents({required this.name});
}

class UpdateCommentCount extends SearchEvent {
  final int productId;

  UpdateCommentCount({
    required this.productId,
  });
}

class UpdateRate extends SearchEvent {
  final double rate;

  UpdateRate({
    required this.rate,
  });
}
