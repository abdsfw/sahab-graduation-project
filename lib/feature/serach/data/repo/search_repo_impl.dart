import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/serach/data/model/search_services_model.dart';
import 'package:sahab/feature/serach/data/model/serach_place_model.dart';
import 'package:sahab/feature/serach/data/repo/search_repo.dart';
import 'package:sahab/feature/services/data/model/service.dart';

class SearchRepoImpl implements SearchRepo {
  String searchPlaceEndPoint = '/places/search/?search=';
  String searchServicesEndPoint = '/services/search/?search=';
  @override
  Future<Either<Failure, Tuple2<List<SearchPlaceModel>, num>>>
      fetchSearchPlaces(String searchQuery, {String? query}) async {
    try {
      List<SearchPlaceModel> placeList = [];
      var response;
      if (query != null) {
        response = await getIt
            .get<ApiService>()
            .get(endPoint: "$searchPlaceEndPoint$searchQuery&$query");
      } else {
        response = await getIt
            .get<ApiService>()
            .get(endPoint: "$searchPlaceEndPoint$searchQuery");
      }
      for (var place in response) {
        placeList.add(SearchPlaceModel.fromJson(place));
      }

      num totalPrice = 0;
      for (var element in placeList) {
        if (element.weekdayPrice > totalPrice) {
          totalPrice = element.weekdayPrice;
        }
      }
      return right(Tuple2(placeList, totalPrice));
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetch search places` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, Tuple2<List<Services>, num>>> fetchSearchServices(
      String searchQuery,
      {String? query}) async {
    try {
      List<Services> servicesList = [];
      var response;
      if (query != null) {
        response = await getIt
            .get<ApiService>()
            .get(endPoint: "$searchServicesEndPoint$searchQuery&$query");
      } else {
        response = await getIt
            .get<ApiService>()
            .get(endPoint: "$searchServicesEndPoint$searchQuery");
      }
      for (var service in response) {
        servicesList.add(Services.fromJson(service));
      }

      num totalPrice = 0;
      for (var element in servicesList) {
        if (element.price > totalPrice) {
          totalPrice = element.price;
        }
      }
      return right(Tuple2(servicesList, totalPrice));
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetch service places` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }
}
