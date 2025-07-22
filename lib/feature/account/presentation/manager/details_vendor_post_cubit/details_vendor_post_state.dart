part of 'details_vendor_post_cubit.dart';

sealed class DetailsVendorPostState extends Equatable {
  const DetailsVendorPostState();

  @override
  List<Object> get props => [];
}

final class DetailsVendorPostInitial extends DetailsVendorPostState {}

final class LoadingGetDetailsPostState extends DetailsVendorPostState {}

final class FailureGetDetailsPostState extends DetailsVendorPostState {
  final String errMessage;

  const FailureGetDetailsPostState(this.errMessage);
}

final class SuccessGetDetailsPostPlaceState extends DetailsVendorPostState {
  final PlacePostDetailsModel placePostDetailsModel;

  const SuccessGetDetailsPostPlaceState(this.placePostDetailsModel);
}

final class SuccessGetDetailsPostServiceState extends DetailsVendorPostState {
  final ServiceModel serviceModel;

  const SuccessGetDetailsPostServiceState(this.serviceModel);
}
