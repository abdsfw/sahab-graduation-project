part of 'tab_switch_cubit.dart';

sealed class TabSwitchState extends Equatable {
  const TabSwitchState();

  @override
  List<Object> get props => [];
}

final class TabSwitchInitial extends TabSwitchState {}

final class ServicesTab extends TabSwitchState {}

final class PlacesTab extends TabSwitchState {}
