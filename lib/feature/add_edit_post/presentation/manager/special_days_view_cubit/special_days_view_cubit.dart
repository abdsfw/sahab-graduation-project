import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';

part 'special_days_view_state.dart';

class SpecialDaysViewCubit extends Cubit<SpecialDaysViewState> {
  SpecialDaysViewCubit() : super(ListViewSpecialDaysViewState());
  void updateListViewState(context) {
    if (BlocProvider.of<NextPostPlaceCubit>(context).specialDaysList.isEmpty) {
      emit(SpecialDaysViewInitial());
    } else {
      emit(ListViewSpecialDaysViewState());
    }
  }
}
