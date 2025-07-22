part of 'service_booking_cubit.dart';

sealed class ServiceBookingState extends Equatable {
  const ServiceBookingState();

  @override
  List<Object> get props => [];
}

final class ServiceBookingInitial extends ServiceBookingState {}

final class LoadingGetServiceDataState extends ServiceBookingState {}

final class FailureGetServiceDataState extends ServiceBookingState {
  final String errMessage;

  const FailureGetServiceDataState(this.errMessage);
}

final class SuccessGetServiceDataState extends ServiceBookingState {
  final List<ServiceBookingDataModel> serviceBookingData;

  const SuccessGetServiceDataState(this.serviceBookingData);
}
