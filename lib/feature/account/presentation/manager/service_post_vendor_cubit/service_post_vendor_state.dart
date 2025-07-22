part of 'service_post_vendor_cubit.dart';

sealed class ServicePostVendorState extends Equatable {
  const ServicePostVendorState();

  @override
  List<Object> get props => [];
}

final class ServicePostVendorInitial extends ServicePostVendorState {}

final class LoadingServicePostVendorState extends ServicePostVendorState {}

final class FailureServicePostVendorState extends ServicePostVendorState {
  final String errMessage;

  FailureServicePostVendorState(this.errMessage);
}

final class SuccessServicePostVendorState extends ServicePostVendorState {
  final List<VendorServicePostModel> serviceVendorList;

  SuccessServicePostVendorState(this.serviceVendorList);
}
