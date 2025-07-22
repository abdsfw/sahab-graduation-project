import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/categories/data/repo/category_repo.dart';
import 'package:sahab/feature/places/data/model/place_model.dart';

import '../../../data/model/category_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  // ! -------- Var -----------------
  static CategoryCubit get(context) => BlocProvider.of(context);
  List<CategoryModel> fetchCategoryList = [];
  List<PlaceModel> fetchPlaceList = [];
  num total = 0;
  num maxPrice = 0;
  String? query;
  //! ----------------- end var ------------------
  //! ------------ functions -------------------
  //?  fetch all category for this user
  Future<void> fetchCategory(context) async {
    emit(CategoryLoading());
    Either<Failure, List<CategoryModel>> result =
        await getIt.get<CategoryRepo>().fetchHomeCategory("place", context);
    result.fold((error) => emit(CategoryFailure(error.errMassage)),
        (fetchedList) {
      fetchCategoryList = fetchedList;
      emit(CategorySuccess());
    });
  }

//! this is pagination
  Future<void> fetchPlaceForOneCategory(
      {int pageNumber = 1, int? categoryId, String? query}) async {
    debugPrint('categoryId: ${categoryId}');
    //? this Function call Api to fetch Place For on category
    if (pageNumber == 1) {
      emit(PlaceCategoryLoading());
    }
    Either<Failure, Tuple2<List<PlaceModel>, Map<String, num>>> result =
        await getIt.get<CategoryRepo>().fetchPlaceForOneCategory(
            pageNumber: pageNumber, categoryId: categoryId ?? -1, query: query);
    result.fold(
      (error) {
        print(error.errMassage);
        if (pageNumber == 1) {
          emit(PlaceCategoryLoadFailure(error.errMassage));
        } else {
          emit(PlaceCategoryPaginationFailure(
              error.errMassage, error.statusCode));
        }
      },
      (fetchedList) {
        //? you can go to category repo impl to show the key

        total = fetchedList.value2["total"] ?? 0;
        if (query == null) {
          maxPrice = fetchedList.value2["max_price"] ?? 0;
        }
        if (fetchedList.value1.isNotEmpty) {
          // emit(PlaceCategoryLoadMore(placeList: fetchedList.value1));
          emit(PlaceCategoryLoadMore());
          fetchPlaceList = fetchedList.value1;
          if (total == 1) {
            emit(PlaceCategoryLoadSuccess());
          }
        } else if (total == 1) {
          emit(PlaceCategoryLoadSuccess());
        } else {
          emit(PlaceCategoryLoadSuccess());
        }
      },
    );
  }
}
