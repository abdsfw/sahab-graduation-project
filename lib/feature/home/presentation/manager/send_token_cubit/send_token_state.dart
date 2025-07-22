part of 'send_token_cubit.dart';

sealed class SendTokenState extends Equatable {
  const SendTokenState();

  @override
  List<Object> get props => [];
}

final class SendTokenInitial extends SendTokenState {}

final class SendTokenLoading extends SendTokenState {}

final class SendTokenSuccess extends SendTokenState {}

final class SendTokenFailure extends SendTokenState {
  final String errMessage;

  SendTokenFailure({required this.errMessage});
}
