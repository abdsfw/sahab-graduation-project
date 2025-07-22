part of 'next_post_service_cubit.dart';

sealed class NextPostServiceState extends Equatable {
  const NextPostServiceState();

  @override
  List<Object> get props => [];
}

final class ServiceStepOnePostInitial extends NextPostServiceState {}

final class ServiceStepTowPostState extends NextPostServiceState {}

final class ServiceCanMovePostState extends NextPostServiceState {}

final class ServiceCanNotMovePostState extends NextPostServiceState {}

final class CanPostState extends NextPostServiceState {}
