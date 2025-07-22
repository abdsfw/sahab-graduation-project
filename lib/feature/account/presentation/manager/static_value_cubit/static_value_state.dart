part of 'static_value_cubit.dart';

sealed class StaticValueState extends Equatable {
  const StaticValueState();

  @override
  List<Object> get props => [];
}

final class StaticValueInitial extends StaticValueState {}

final class StaticValueLoading extends StaticValueState {}

final class StaticValueSuccess extends StaticValueState {}

final class StaticValueFailure extends StaticValueState {
  final String errMessage;

  StaticValueFailure({required this.errMessage});
}
