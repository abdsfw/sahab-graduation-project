import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_switch_state.dart';

class TabSwitchCubit extends Cubit<TabSwitchState> {
  TabSwitchCubit() : super(TabSwitchInitial());
  static TabSwitchCubit get(context) => BlocProvider.of(context);
  void placesTab() {
    emit(PlacesTab());
  }

  void servicesTab() {
    emit(ServicesTab());
  }
}
