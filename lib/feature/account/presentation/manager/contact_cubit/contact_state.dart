part of 'contact_cubit.dart';

sealed class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

final class ContactInitial extends ContactState {}

final class ContactLoading extends ContactState {}

final class ContactSuccess extends ContactState {}

final class ContactFailure extends ContactState {
  final String errMessage;

  ContactFailure({required this.errMessage});
}
