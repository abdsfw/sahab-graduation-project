part of 'service_reservation_cubit.dart';

sealed class ServiceReservationState extends Equatable {
  const ServiceReservationState();

  @override
  List<Object> get props => [];
}

final class ServiceReservationInitial extends ServiceReservationState {}

final class LoadingGetReservationServiceDataState
    extends ServiceReservationState {}

final class FailureGetReservationServiceDataState
    extends ServiceReservationState {
  final String errMessage;

  const FailureGetReservationServiceDataState(this.errMessage);
}

final class SuccessGetReservationServiceDataState
    extends ServiceReservationState {
  final List<ServiceReservationDataModel> serviceReservationData;

  const SuccessGetReservationServiceDataState(this.serviceReservationData);
}
