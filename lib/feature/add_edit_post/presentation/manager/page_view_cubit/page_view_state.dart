part of 'page_view_cubit.dart';

sealed class PageViewState extends Equatable {
  const PageViewState();

  @override
  List<Object> get props => [];
}

final class FirstPageViewState extends PageViewState {}

final class SecondPageViewState extends PageViewState {}
