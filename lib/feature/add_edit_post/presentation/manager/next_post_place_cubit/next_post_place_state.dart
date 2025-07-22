part of 'next_post_place_cubit.dart';

sealed class NextPostPlaceState extends Equatable {
  const NextPostPlaceState();

  @override
  List<Object> get props => [];
}

final class StepOnePostInitial extends NextPostPlaceState {}

final class StepTowPostState extends NextPostPlaceState {}

final class CanMovePostState extends NextPostPlaceState {}

final class CanNotMovePostState extends NextPostPlaceState {}

final class CanPostState extends NextPostPlaceState {}

// final class CanNotPostState extends NextPostPlaceState {}

final class GetAmenityLoadingState extends NextPostPlaceState {}

final class GetAmenityFailureState extends NextPostPlaceState {
  final String errMessage;

  const GetAmenityFailureState(this.errMessage);
}

final class GetAmenitySuccessState extends NextPostPlaceState {}

final class SelectAmenityState1 extends NextPostPlaceState {}

final class SelectAmenityState2 extends NextPostPlaceState {}

final class RemoveAmenityState1 extends NextPostPlaceState {}

final class RemoveAmenityState2 extends NextPostPlaceState {}
