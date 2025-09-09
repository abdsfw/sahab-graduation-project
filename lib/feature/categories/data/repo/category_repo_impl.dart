import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:sahab/feature/categories/data/repo/category_repo.dart';
import 'package:sahab/feature/places/data/model/place_model.dart';

import '../model/category_model.dart';

class CategoryRepoImpl implements CategoryRepo {
  final String categoryEndPoint = '/categories';
  @override
  Future<Either<Failure, List<CategoryModel>>> fetchHomeCategory(
      String type, context) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;
      var response = await getIt
          .get<ApiService>()
          .get(endPoint: "$categoryEndPoint/type/?type=$type&language=$lang");
      List<CategoryModel> categoryList = [];
      for (var categoryItem in response) {
        categoryList.add(CategoryModel.fromJson(categoryItem));
      }

      return right(categoryList);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetchHomeCategory` method $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, Tuple2<List<PlaceModel>, Map<String, num>>>>
      fetchPlaceForOneCategory(
          {int pageNumber = 0, int? categoryId, String? query}) async {
    try {
      debugPrint('query: ${query}');
      debugPrint('categoryId: ${categoryId}');
      debugPrint('pageNumber: ${pageNumber}');
      List<PlaceModel> placeList = [];
      var response;
      if (query != null) {
        response = await getIt.get<ApiService>().get(
              endPoint:
                  "/categories/$categoryId/places?page=$pageNumber&per_page=5&$query",
            );
      } else {
        response = await getIt.get<ApiService>().get(
            endPoint:
                "/categories/$categoryId/places?page=$pageNumber&per_page=5");
      }
      print(response);
      for (var place in response['data']['places']['data']) {
        placeList.add(PlaceModel.fromJson(place));
      }
      Map<String, num> importantData = {};
      int totalCount = response['data']["places"]['total'] ?? 0;
      importantData["total"] = totalCount;
      // importantData.add(totalCount);
      num maxPrice = response['data']['max_price'] ?? 0;
      importantData["max_price"] = maxPrice;
      // importantData.add(maxPrice);
      log("Fetch Place Success there are ${placeList.length} places");
      return right(Tuple2(placeList, importantData));
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetch places For category` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 800));
    }
  }
}
