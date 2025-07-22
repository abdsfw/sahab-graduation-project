part of 'terminal_account_cubit.dart';

sealed class TerminalAccountState extends Equatable {
  const TerminalAccountState();

  @override
  List<Object> get props => [];
}

final class TerminalAccountInitial extends TerminalAccountState {}

final class TerminalAccountLoading extends TerminalAccountState {}

final class TerminalAccountSuccess extends TerminalAccountState {}

final class TerminalAccountFailure extends TerminalAccountState {
  final String errMessage;

  const TerminalAccountFailure({required this.errMessage});
}
