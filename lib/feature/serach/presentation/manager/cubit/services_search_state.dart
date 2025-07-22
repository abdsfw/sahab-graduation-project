part of 'services_search_cubit.dart';

sealed class ServicesSearchState extends Equatable {
  const ServicesSearchState();

  @override
  List<Object> get props => [];
}

final class ServicesSearchInitial extends ServicesSearchState {}

final class ServicesSearchLoading extends ServicesSearchState {}

final class ServicesSearchSuccess extends ServicesSearchState {}

final class ServicesSearchFailure extends ServicesSearchState {
  final String errMessage;

  const ServicesSearchFailure({required this.errMessage});
}
