part of 'details_delete_cubit.dart';

sealed class DetailsDeleteState extends Equatable {
  const DetailsDeleteState();

  @override
  List<Object> get props => [];
}

final class DetailsDeleteInitial extends DetailsDeleteState {}

final class LoadingDeletePostState extends DetailsDeleteState {}

final class FailureDeletePostState extends DetailsDeleteState {
  final String errMessage;

  FailureDeletePostState(this.errMessage);
}

final class SuccessDeletePostState extends DetailsDeleteState {}
