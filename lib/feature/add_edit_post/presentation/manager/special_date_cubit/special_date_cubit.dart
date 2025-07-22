import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';

part 'special_date_state.dart';

class SpecialDateCubit extends Cubit<SpecialDateState> {
  SpecialDateCubit() : super(SpecialDateInitial());
  DateTimeRange? specialDateChosen;

  void checkIfCanAdd(context) {
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);

    bool titleCheck =
        nextPostPlaceCubit.titleSpecialDateController.text.isEmpty;
    bool priceCheck =
        nextPostPlaceCubit.priceSpecialDateController.text.isEmpty;
    bool dateCheck = (nextPostPlaceCubit.specialDateChosen == null);
    if (!titleCheck && !priceCheck && !dateCheck) {
      emit(SuccessSpecialDateState());
    } else {
      emit(SpecialDateInitial());
    }
  }
}
