import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/home/data/model/user_check_model.dart';
import 'package:sahab/feature/home/data/repo/home_repo.dart';
import 'package:sahab/feature/places/data/model/place_details_model.dart';

import '../../../places/data/model/place_details_model/place_image.dart';

class HomeRepoImpl implements HomeRepo {
  String homeEndPoint = "/home-images";
  @override
  Future<Either<Failure, List<PlaceImage>>> getHomePic() async {
    try {
      List<PlaceImage> homeImage = [];
      dynamic response =
          await getIt.get<ApiService>().get(endPoint: homeEndPoint);
      for (var image in response) {
        homeImage.add(PlaceImage.fromJson(image));
      }
      return right(homeImage);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetch home images` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, String>> sendToken(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await getIt.get<ApiService>().post(endPoint: "sendtoken", data: data);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetch home images` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, UserCheckModel>> checkUserRole() async {
    try {
      dynamic response =
          await getIt.get<ApiService>().get(endPoint: "/users/check-role");
      UserCheckModel userModel = UserCheckModel.fromJson(response);
      return right(userModel);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `checkUserRole` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<dynamic> fetchSvgData({required String url}) async {
    try {
      Response response = await getIt.get<ApiService>().get(endPoint: url);
      return response.data;
    } catch (error) {
      throw Exception('Failed to load data: $error');
    }
  }
}
