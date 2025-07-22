part of 'details_reservation_cubit.dart';

sealed class DetailsReservationState extends Equatable {
  const DetailsReservationState();

  @override
  List<Object> get props => [];
}

final class DetailsReservationInitial extends DetailsReservationState {}

final class LoadingFetchServiceDetails extends DetailsReservationState {}

final class FailureFetchServiceDetails extends DetailsReservationState {
  final String errMessage;

  const FailureFetchServiceDetails(this.errMessage);
}

final class SuccessFetchServiceDetails extends DetailsReservationState {
  final ServiceReservationDetailsModel serviceDetail;

  const SuccessFetchServiceDetails(this.serviceDetail);
}

final class LoadingFetchPlaceDetails extends DetailsReservationState {}

final class FailureFetchPlaceDetails extends DetailsReservationState {
  final String errMessage;

  const FailureFetchPlaceDetails(this.errMessage);
}

final class SuccessFetchPlaceDetails extends DetailsReservationState {
  final PlaceReservationDetailsModel placeDetail;

  const SuccessFetchPlaceDetails(this.placeDetail);
}
