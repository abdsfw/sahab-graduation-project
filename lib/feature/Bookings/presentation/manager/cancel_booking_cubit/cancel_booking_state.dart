part of 'cancel_booking_cubit.dart';

sealed class CancelBookingState extends Equatable {
  const CancelBookingState();

  @override
  List<Object> get props => [];
}

final class CancelBookingInitial extends CancelBookingState {}

final class LoadingCancelBookingState extends CancelBookingState {}

final class FailureCancelBookingState extends CancelBookingState {
  final String errMessage;

  FailureCancelBookingState(this.errMessage);
}

final class SuccessCancelBookingState extends CancelBookingState {}
