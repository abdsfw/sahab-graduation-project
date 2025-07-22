part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class LoadingFetchUserData extends HomeState {}

final class FailureFetchUserData extends HomeState {}

final class SuccessFetchUserData extends HomeState {}
