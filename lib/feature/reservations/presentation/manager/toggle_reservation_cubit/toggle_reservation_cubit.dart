import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/enums/type_post_enum.dart';

part 'toggle_reservation_state.dart';

class ToggleReservationCubit extends Cubit<ToggleReservationState> {
  ToggleReservationCubit() : super(PlaceReservationPageState());

  void togglePlaceService(TypeToggle typeToggle) {
    switch (typeToggle) {
      case TypeToggle.service:
        emit(ServiceReservationPageState());
      case TypeToggle.place:
        emit(PlaceReservationPageState());
    }
  }
}
