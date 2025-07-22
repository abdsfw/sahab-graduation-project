part of '../place_cubit/place_cubit.dart';

sealed class PlaceState {
  const PlaceState();
}

class PlaceInitial extends PlaceState {}

class PlaceLoading extends PlaceState {}

class PlaceLoadSuccess extends PlaceState {}

class PlaceLoadMore extends PlaceState {}

class PlaceLoadFailure extends PlaceState {
  final String errorMessage;
  final int statusCode;
  const PlaceLoadFailure(this.errorMessage, this.statusCode);

  @override
  List<Object> get props => [errorMessage];
}

class PlacePaginationFailure extends PlaceState {
  final String errorMessage;

  const PlacePaginationFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class RadioFilterState extends PlaceState {}
