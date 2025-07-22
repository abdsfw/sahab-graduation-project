part of 'static_page_cubit.dart';

sealed class StaticPageState extends Equatable {
  const StaticPageState();

  @override
  List<Object> get props => [];
}

final class StaticPageInitial extends StaticPageState {}

final class StaticPageLoading extends StaticPageState {}

final class StaticPageSuccess extends StaticPageState {}

final class StaticPageFailure extends StaticPageState {
  final String errMessage;

  StaticPageFailure({required this.errMessage});
}
