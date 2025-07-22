part of 'service_details_home_cubit.dart';

sealed class ServiceDetailsHomeState extends Equatable {
  const ServiceDetailsHomeState();

  @override
  List<Object> get props => [];
}

final class ServiceDetailsHomeInitial extends ServiceDetailsHomeState {}

final class LoadingDetailsHomeState extends ServiceDetailsHomeState {}

final class FailureDetailsHomeState extends ServiceDetailsHomeState {}

final class SuccessDetailsHomeState extends ServiceDetailsHomeState {
  final ServiceDetailsModel details;

  SuccessDetailsHomeState(this.details);
}
