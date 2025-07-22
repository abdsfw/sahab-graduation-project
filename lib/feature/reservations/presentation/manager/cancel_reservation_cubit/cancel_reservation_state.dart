part of 'cancel_reservation_cubit.dart';

sealed class CancelReservationState extends Equatable {
  const CancelReservationState();

  @override
  List<Object> get props => [];
}

final class CancelReservationInitial extends CancelReservationState {}

final class LoadingCancelReservationState extends CancelReservationState {}

final class FailureCancelReservationState extends CancelReservationState {
  final String errMessage;

  const FailureCancelReservationState(this.errMessage);
}

final class SuccessCancelReservationState extends CancelReservationState {}
