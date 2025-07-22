import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/core/utils/extension/date_time_extension.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:sahab/feature/places/data/model/featured_place/feature_place_model/feature_place_model.dart';
import 'package:sahab/feature/places/data/model/featured_place/featured_place.dart';
import 'package:sahab/feature/places/data/model/place_details_model.dart';
import 'package:sahab/feature/places/data/model/place_details_model/place_details_model.dart';
import 'package:sahab/feature/places/data/repo/place_repo.dart';

import '../../../../core/errors/failures.dart';
import '../model/place_model.dart';

class PlaceRepoImpl implements PlaceRepo {
  final String placeEndPoint = '/places';

  // @override
  // Future<Either<Failure, Tuple2<List<PlaceModel>, int>>> fetchHomePlaces(
  //     {int pageNumber = 1, String? query}) async {
  //   try {
  //     String filterEndPoint =
  //         "/categories/1/places?page=$pageNumber&per_page=2";

  //     List<PlaceModel> placeList = [];
  //     if (query != null) {
  //       filterEndPoint += "/?filter=$query";
  //     }
  //     print(filterEndPoint);
  //     var response =
  //         await getIt.get<ApiService>().get(endPoint: filterEndPoint);
  //     for (var place in response['data']['places']['data']) {
  //       placeList.add(PlaceModel.fromJson(place));
  //     }
  //     int totalCount = response['data']["places"]['total'];
  //     log("Fetch Place Success there are ${placeList.length} places");
  //     return right(Tuple2(placeList, totalCount));
  //   } catch (e) {
  //     if (e is DioException) {
  //       log("dio Exception from `fetch places` method");
  //       log("this is the error $e");
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     log("un expected error");
  //     return left(ServerFailure(e.toString(), 600));
  //   }
  // }

  @override
  Future<Either<Failure, PlaceDetailsModel>> fetchPlacesDetails(context,
      {required int placeId}) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt
          .get<ApiService>()
          .get(endPoint: "$placeEndPoint/$placeId?language=$lang");
      var placeDetails = PlaceDetailsModel.fromJson(response);
      return right(placeDetails);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetch places` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, List<DateTime>>> fetchIgnoreDates(
      {required int placeId}) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .get(endPoint: "/places/$placeId/bookings");
      List<DateTime> listData = [];
      for (var date in response) {
        listData.add(DateTime.parse(date as String).truncateToDay());
      }
      return right(listData);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetchIgnoreDates` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, Tuple2<List<FeaturePlaceModel>, num>>>
      fetchAllFuturePlaces(context, {String? query}) async {
    String lang = BlocProvider.of<LangCubit>(context).lang;

    try {
      var response;
      if (query != null) {
        response = await getIt
            .get<ApiService>()
            .get(endPoint: "/places/featured/get/?$query&language=$lang");
      } else {
        response = await getIt
            .get<ApiService>()
            .get(endPoint: "/places/featured/get/?language=$lang");
      }
      List<FeaturePlaceModel> pleases = [];
      for (var element in response) {
        // print("image length");
        // print(element["place_images"][0]);
        print("----------------------");
        print(element);
        print("----------------------");
        pleases.add(FeaturePlaceModel.fromJson(element));
      }
      print("plaaaces");
      // print(pleases[0].placeImages?.length);
      num maxPrice = 0;
      for (var place in pleases) {
        num weekDayPrice = place.weekdayPrice ?? 0;
        if (weekDayPrice > maxPrice) {
          maxPrice = weekDayPrice;
        }
      }
      return right(Tuple2(pleases, maxPrice));
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetchIgnoreDates` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error$e");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, List<PlaceModel>>> fetchAllPlaces() {
    // TODO: implement fetchAllPlaces
    throw UnimplementedError();
  }
}
