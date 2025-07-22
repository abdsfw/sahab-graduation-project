part of 'area_cubit.dart';

sealed class AreaState {}

final class AreaInitial extends AreaState {}

final class GetAllAreaLoadingState extends AreaState {}

final class GetAllAreaFailureState extends AreaState {
  final String errMessage;

  GetAllAreaFailureState(this.errMessage);
}

final class GetAllAreaSuccessState extends AreaState {}
