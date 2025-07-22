part of 'rating_cubit.dart';

sealed class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

final class RatingInitial extends RatingState {}

final class RatingExcellentState extends RatingState {}

final class RatingGoodState extends RatingState {}

final class RatingBadState extends RatingState {}
