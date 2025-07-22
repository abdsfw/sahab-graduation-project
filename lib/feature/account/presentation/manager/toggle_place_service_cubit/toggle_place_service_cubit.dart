import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/enums/type_post_enum.dart';

part 'toggle_place_service_state.dart';

class TogglePlaceServiceCubit extends Cubit<TogglePlaceServiceState> {
  TogglePlaceServiceCubit() : super(MyPostPlaceState());
  static TogglePlaceServiceCubit get(context) => BlocProvider.of(context);

  void changeMyPostListView(TypeToggle typePost) {
    switch (typePost) {
      case TypeToggle.service:
        emit(MyPostServiceState());
        break;
      case TypeToggle.place:
        emit(MyPostPlaceState());
        break;
    }
  }
}
