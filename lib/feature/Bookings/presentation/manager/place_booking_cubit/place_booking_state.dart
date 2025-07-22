part of 'place_booking_cubit.dart';

sealed class PlaceBookingState extends Equatable {
  const PlaceBookingState();

  @override
  List<Object> get props => [];
}

final class PlaceBookingInitial extends PlaceBookingState {}

final class LoadingGetPlaceDataState extends PlaceBookingState {}

final class FailureGetPlaceDataState extends PlaceBookingState {
  final String errMessage;

  const FailureGetPlaceDataState(this.errMessage);
}

final class SuccessGetPlaceDataState extends PlaceBookingState {
  final List<PlaceBookingDataModel> placeBookingData;

  const SuccessGetPlaceDataState(this.placeBookingData);
}
