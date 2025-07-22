part of 'skip_cubit.dart';

sealed class SkipState extends Equatable {
  const SkipState();

  @override
  List<Object> get props => [];
}

final class SkipInitial extends SkipState {}

final class LoadingGetPhotoState extends SkipState {}

final class FailureGetPhotoState extends SkipState {
  final String errMessage;

  FailureGetPhotoState(this.errMessage);
}

final class SuccessGetPhotoState extends SkipState {
  final SkipModel skipData;

  SuccessGetPhotoState(this.skipData);
}
