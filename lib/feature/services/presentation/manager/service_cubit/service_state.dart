part of '../service_cubit/service_cubit.dart';

sealed class ServiceState {
  const ServiceState();
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoadSuccess extends ServiceState {}

class ServiceLoadFailure extends ServiceState {
  final String errorMessage;

  const ServiceLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ServiceChangeFlitter extends ServiceState {
  final int flitterType;

  ServiceChangeFlitter({required this.flitterType});
}
