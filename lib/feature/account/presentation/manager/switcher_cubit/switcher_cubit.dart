import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/enums/type_post_enum.dart';

part 'switcher_state.dart';

class SwitcherCubit extends Cubit<SwitcherState> {
  SwitcherCubit() : super(SwitcherInitial());
  static SwitcherCubit get(context) => BlocProvider.of(context);

  bool? postActive;
  bool? bookingActive;
  void setPostBookingVar({bool? postActive, bool? bookingActive}) {
    this.postActive = postActive;
    this.bookingActive = bookingActive;
  }

  void changeBoolVariable({required bool isPost, required bool value}) {
    if (isPost) {
      postActive = value;
    } else {
      bookingActive = value;
    }
    emit(SwitcherInitial());
  }
}
