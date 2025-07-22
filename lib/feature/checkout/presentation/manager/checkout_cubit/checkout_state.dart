part of 'checkout_cubit.dart';

sealed class CheckoutState
// extends Equatable
{
  // const CheckoutState();

  // @override
  // List<Object> get props => [];
}

final class CheckoutInitial extends CheckoutState {}

final class LoadingCheckoutState extends CheckoutState {}

final class FirstFailureCheckoutState extends CheckoutState {
  final String errMessage;

  FirstFailureCheckoutState(this.errMessage);
}

final class FinalFailureCheckoutState extends CheckoutState {}

final class FirstSuccessCheckoutState extends CheckoutState {
  final AddBookingResponseModel bookingResponse;

  FirstSuccessCheckoutState(this.bookingResponse);
}

final class FinalSuccessCheckoutState extends CheckoutState {}
