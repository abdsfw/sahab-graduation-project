part of 'place_booking_date_cubit.dart';

sealed class PlaceBookingDateState {}

final class PlaceBookingInitial extends PlaceBookingDateState {}

final class SelectedDatesPlaceBookingState extends PlaceBookingDateState {}

final class LoadingFetchIgnoreDatesState extends PlaceBookingDateState {}

final class FailureFetchIgnoreDatesState extends PlaceBookingDateState {
  final String errMessage;

  FailureFetchIgnoreDatesState(this.errMessage);
}

final class SuccessFetchIgnoreDatesState extends PlaceBookingDateState {}
