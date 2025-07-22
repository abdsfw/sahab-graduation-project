part of '../service_category_cubit/services_category_cubit.dart';

sealed class ServicesCategoryState extends Equatable {
  const ServicesCategoryState();

  @override
  List<Object> get props => [];
}

final class ServicesCategoryInitial extends ServicesCategoryState {}

class ServicesCategoryLoading extends ServicesCategoryState {}

class ServicesCategoryLoadSuccess extends ServicesCategoryState {}

class ServicesCategoryLoadMore extends ServicesCategoryState {
  const ServicesCategoryLoadMore();
}

class ServicesCategoryLoadFailure extends ServicesCategoryState {
  final String errorMessage;

  const ServicesCategoryLoadFailure(this.errorMessage);
}

class ServicesCategoryPaginationFailure extends ServicesCategoryState {
  final String errorMessage;
  final int statusCode;
  const ServicesCategoryPaginationFailure(this.errorMessage, this.statusCode);
}
