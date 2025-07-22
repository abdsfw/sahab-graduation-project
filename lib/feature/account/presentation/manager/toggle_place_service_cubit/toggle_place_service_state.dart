part of 'toggle_place_service_cubit.dart';

sealed class TogglePlaceServiceState extends Equatable {
  const TogglePlaceServiceState();

  @override
  List<Object> get props => [];
}

final class MyPostPlaceState extends TogglePlaceServiceState {}

final class MyPostServiceState extends TogglePlaceServiceState {}
