part of 'toggle_reservation_cubit.dart';

sealed class ToggleReservationState extends Equatable {
  const ToggleReservationState();

  @override
  List<Object> get props => [];
}

final class PlaceReservationPageState extends ToggleReservationState {}

final class ServiceReservationPageState extends ToggleReservationState {}
