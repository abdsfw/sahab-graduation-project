part of 'toggle_cubit.dart';

sealed class ToggleState extends Equatable {
  const ToggleState();

  @override
  List<Object> get props => [];
}

// final class AddEditPostInitial extends ToggleState {}

final class AddPlacePostState extends ToggleState {}

final class AddServicesPostState extends ToggleState {}
