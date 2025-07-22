import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/enums/type_post_enum.dart';

part 'booking_toggle_state.dart';

class BookingToggleCubit extends Cubit<BookingToggleState> {
  BookingToggleCubit() : super(PlaceBookingPageState());

  void togglePlaceService(TypeToggle typePost) {
    switch (typePost) {
      case TypeToggle.service:
        emit(ServiceBookingPageState());
      case TypeToggle.place:
        emit(PlaceBookingPageState());
    }
  }
}
