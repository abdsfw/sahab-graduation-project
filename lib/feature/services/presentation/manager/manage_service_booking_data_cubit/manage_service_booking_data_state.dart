part of 'manage_service_booking_data_cubit.dart';

sealed class ManageServiceBookingDataState {
  // const ManageServiceBookingDataState();

  // @override
  // List<Object> get props => [];
}

final class ManageServiceBookingDataInitial
    extends ManageServiceBookingDataState {}

final class SuccessToGoToCheckout extends ManageServiceBookingDataState {}
