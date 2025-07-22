part of 'boarding_cubit.dart';

sealed class BoardingState extends Equatable {
  const BoardingState();

  @override
  List<Object> get props => [];
}

final class BoardingInitial extends BoardingState {}

final class ChangeSplashScreenState extends BoardingState {}

final class ChangeSkipScreenState extends BoardingState {}
