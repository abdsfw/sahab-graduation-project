part of 'booking_cubit.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {}

final class LoadingFetchDetailsBookingState extends BookingState {}

final class FailureFetchDetailsBookingState extends BookingState {
  final String errMessage;

  FailureFetchDetailsBookingState(this.errMessage);
}

final class SuccessFetchDetailsBookingState extends BookingState {}
