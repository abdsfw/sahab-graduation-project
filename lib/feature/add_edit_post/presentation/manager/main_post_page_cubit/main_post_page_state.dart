part of 'main_post_page_cubit.dart';

sealed class MainPostPageState extends Equatable {
  const MainPostPageState();

  @override
  List<Object> get props => [];
}

final class MainPostPageInitial extends MainPostPageState {}

// final class GetAllAreaLoadingState extends MainPostPageState {}

// final class GetAllAreaFailureState extends MainPostPageState {
//   final String errMessage;

//   const GetAllAreaFailureState(this.errMessage);
// }

// final class GetAllAreaSuccessState extends MainPostPageState {}

final class GetAllDropDownListLoadingState extends MainPostPageState {}

final class GetAllDropDownListFailureState extends MainPostPageState {
  final String errMessage;

  const GetAllDropDownListFailureState(this.errMessage);
}

final class GetAllDropDownListSuccessState extends MainPostPageState {}
