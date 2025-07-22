part of 'place_details_cubit.dart';

sealed class PlaceDetailsState extends Equatable {
  const PlaceDetailsState();

  @override
  List<Object> get props => [];
}

final class PlaceDetailsInitial extends PlaceDetailsState {}

class PlaceDetailsLoading extends PlaceDetailsState {}

class PlaceDetailsLoadSuccess extends PlaceDetailsState {
  final PlaceDetailsModel placeDetails;

  const PlaceDetailsLoadSuccess(this.placeDetails);

  @override
  List<Object> get props => [placeDetails];
}

class PlaceDetailsLoadFailure extends PlaceDetailsState {
  final String errorMessage;

  const PlaceDetailsLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
