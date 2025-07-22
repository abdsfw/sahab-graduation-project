part of 'service_booking_date_cubit.dart';

sealed class ServiceBookingDateState {
  // const ServiceBookingDateState();

  // @override
  // List<Object> get props => [];
}

final class ServiceBookingDateInitial extends ServiceBookingDateState {}

final class LoadingFetchServiceDates extends ServiceBookingDateState {}

final class FailureFetchServiceDates extends ServiceBookingDateState {}

final class SuccessFetchServiceDates extends ServiceBookingDateState {}
