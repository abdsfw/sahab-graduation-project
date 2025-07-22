part of 'payment_cubit.dart';

sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class LoadingFetchPaymentState extends PaymentState {}

final class FailureFetchPaymentState extends PaymentState {
  final String errMessage;

  FailureFetchPaymentState(this.errMessage);
}

final class SuccessFetchPaymentState extends PaymentState {
  final List<PaymentMethod> paymentMethodList;

  SuccessFetchPaymentState(this.paymentMethodList);
}
