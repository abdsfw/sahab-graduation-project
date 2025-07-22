import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit() : super(SliderInitial());
  static SliderCubit get(context) => BlocProvider.of(context);

  late RangeValues rangeValue;
  late double min;
  late double max;
  late int division;

  void setImportantAttribute({
    required RangeValues rangeValues,
    required double min,
    required double max,
    required int division,
  }) {
    this.rangeValue = rangeValues;
    this.min = min;
    this.max = max;
    this.division = division;
  }

  void changeRange(RangeValues rangeValue) {
    this.rangeValue = rangeValue;
    emit(SliderInitial());
  }
}
