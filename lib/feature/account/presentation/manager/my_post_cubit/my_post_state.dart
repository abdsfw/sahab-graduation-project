part of '../my_post_cubit/my_post_cubit.dart';

sealed class MyPostState extends Equatable {
  const MyPostState();

  @override
  List<Object> get props => [];
}

final class MyPostInitial extends MyPostState {}

final class ManageAndDeleteLoadingState extends MyPostState {}

final class ManageAndDeleteFailureState extends MyPostState {
  final String errMessage;

  const ManageAndDeleteFailureState(this.errMessage);
}

final class ManageAndDeletePlaceSuccessState extends MyPostState {}

final class ManageAndDeleteServiceSuccessState extends MyPostState {}
