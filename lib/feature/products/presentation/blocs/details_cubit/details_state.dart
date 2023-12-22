part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsUpdateCommentLoaded extends DetailsState {}

class DetailsUpdateCommentLoading extends DetailsState {}

class RateProductLoading extends DetailsState {}

class RateProductLoaded extends DetailsState {}
