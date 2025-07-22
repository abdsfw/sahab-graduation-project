part of 'add_rating_cubit.dart';

sealed class AddRatingState extends Equatable {
  const AddRatingState();

  @override
  List<Object> get props => [];
}

final class AddRatingInitial extends AddRatingState {}

final class LoadingAddRatingState extends AddRatingState {}

final class FailureAddRatingState extends AddRatingState {
  final String errMessage;

  FailureAddRatingState(this.errMessage);
}

final class SuccessAddRatingState extends AddRatingState {}
