part of 'place_post_vendor_cubit.dart';

sealed class PlacePostVendorState extends Equatable {
  const PlacePostVendorState();

  @override
  List<Object> get props => [];
}

final class PlacePostVendorInitial extends PlacePostVendorState {}

final class LoadingPlacePostVendorState extends PlacePostVendorState {}

final class FailurePlacePostVendorState extends PlacePostVendorState {
  final String errMessage;

  FailurePlacePostVendorState(this.errMessage);
}

final class SuccessPlacePostVendorState extends PlacePostVendorState {
  final List<VendorPlacePostModel> placeVendorList;

  SuccessPlacePostVendorState(this.placeVendorList);
}
