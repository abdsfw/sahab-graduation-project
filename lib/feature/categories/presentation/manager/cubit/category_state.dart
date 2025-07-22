part of 'category_cubit.dart';

sealed class CategoryState {
  const CategoryState();
}

final class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {}

class CategoryFailure extends CategoryState {
  final String error;

  const CategoryFailure(this.error);

  @override
  List<Object> get props => [error];
}

class PlaceCategoryLoading extends CategoryState {}

class PlaceCategoryLoadSuccess extends CategoryState {}

class PlaceCategoryLoadMore extends CategoryState {
  // final List<PlaceModel> placeList;

  PlaceCategoryLoadMore();
}

class PlaceCategoryLoadFailure extends CategoryState {
  final String errorMessage;

  const PlaceCategoryLoadFailure(this.errorMessage);
}

class PlaceCategoryPaginationFailure extends CategoryState {
  final String errorMessage;
  final int statusCode;

  const PlaceCategoryPaginationFailure(this.errorMessage, this.statusCode);
}
