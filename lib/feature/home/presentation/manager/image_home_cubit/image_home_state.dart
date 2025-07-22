part of 'image_home_cubit.dart';

sealed class ImageHomeState extends Equatable {
  const ImageHomeState();

  @override
  List<Object> get props => [];
}

final class ImageHomeInitial extends ImageHomeState {}

final class ImageHomeLoading extends ImageHomeState {}

final class ImageHomeSuccess extends ImageHomeState {}

final class ImageHomeFailure extends ImageHomeState {
  final String errMessage;

  const ImageHomeFailure({required this.errMessage});
}
