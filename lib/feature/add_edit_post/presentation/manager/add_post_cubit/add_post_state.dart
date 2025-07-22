part of 'add_post_cubit.dart';

sealed class AddPostState {
  // const AddPostState();

  // @override
  // List<Object> get props => [];
}

final class AddPostInitial extends AddPostState {}

final class LoadingAddEditPostState extends AddPostState {}

final class FailureAddEditPostState extends AddPostState {}

final class SuccessAddEditPostState extends AddPostState {}
