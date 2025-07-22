part of 'booking_toggle_cubit.dart';

sealed class BookingToggleState extends Equatable {
  const BookingToggleState();

  @override
  List<Object> get props => [];
}

final class PlaceBookingPageState extends BookingToggleState {}

final class ServiceBookingPageState extends BookingToggleState {}
