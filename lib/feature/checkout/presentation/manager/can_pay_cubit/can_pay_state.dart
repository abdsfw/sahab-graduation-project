part of 'can_pay_cubit.dart';

sealed class CanPayState extends Equatable {
  const CanPayState();

  @override
  List<Object> get props => [];
}

final class CanPayInitial extends CanPayState {}

final class CanCompletePayState extends CanPayState {}

final class CanNotCompletePayState extends CanPayState {}
