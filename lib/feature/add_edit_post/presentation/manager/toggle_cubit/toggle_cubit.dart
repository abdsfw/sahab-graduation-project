import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/enums/type_post_enum.dart';

import '../../../../../core/enums/type_adv_enum.dart';

part 'toggle_state.dart';

class ToggleCubit extends Cubit<ToggleState> {
  ToggleCubit() : super(AddPlacePostState());

  void changeAddPostTo(TypeToggle typeToggle) {
    switch (typeToggle) {
      case TypeToggle.place:
        emit(AddPlacePostState());
      case TypeToggle.service:
        emit(AddServicesPostState());
    }
  }
}
