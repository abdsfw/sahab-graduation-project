part of 'place_reservation_cubit.dart';

sealed class PlaceReservationState extends Equatable {
  const PlaceReservationState();

  @override
  List<Object> get props => [];
}

final class PlaceReservationInitial extends PlaceReservationState {}

final class LoadingGetReservationPlaceDataState extends PlaceReservationState {}

final class FailureGetReservationPlaceDataState extends PlaceReservationState {
  final String errMessage;

  const FailureGetReservationPlaceDataState(this.errMessage);
}

final class SuccessGetReservationPlaceDataState extends PlaceReservationState {
  final List<PlaceReservationDataModel> placeReservationData;

  const SuccessGetReservationPlaceDataState(this.placeReservationData);
}
