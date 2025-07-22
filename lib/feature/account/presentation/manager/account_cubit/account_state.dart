part of 'account_cubit.dart';

sealed class AccountState {
  const AccountState();
}

final class AccountInitial extends AccountState {}

class AccountImageLoaded extends AccountState {
  final File image;

  const AccountImageLoaded(this.image);
}

class AccountAnotherImage extends AccountState {
  final File image;

  const AccountAnotherImage(this.image);
}

class AccountEditLoading extends AccountState {}

class AccountEditSuccess extends AccountState {
  final String newImagePath;

  AccountEditSuccess({required this.newImagePath});
}

class AccountEditFailure extends AccountState {
  final String errorMessage;

  const AccountEditFailure({required this.errorMessage});

  @override
  List<Object> get props => [];
}

class StarEditAccount extends AccountState {}

// class AccountTerminateLoading extends AccountState {}

// class AccountTerminateSuccess extends AccountState {}

// class AccountTerminateFailure extends AccountState {
//   final String errMessage;

//   const AccountTerminateFailure({required this.errMessage});
// }
