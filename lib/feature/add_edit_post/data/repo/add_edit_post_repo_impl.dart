import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahab/core/errors/failures.dart';

import 'package:sahab/feature/add_edit_post/data/model/amenity_model.dart';
import 'package:sahab/feature/add_edit_post/data/model/area_model.dart';
import 'package:sahab/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';

import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/service_locator.dart';
import 'add_edit_post_repo.dart';

class AddEditPostRepoImpl extends AddEditPostRepo {
  @override
  Future<Either<Failure, List<AmenityModel>>> fetchAllAmenity(context) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt.get<ApiService>().get(
            endPoint: '/amenities?language=$lang',
          );
      List<AmenityModel> responseList = [];
      for (var amenity in response) {
        responseList.add(AmenityModel.fromJson(amenity));
      }
      return right(responseList);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, List<AreaModel>>> fetchAllArea(context) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt.get<ApiService>().get(
            endPoint: '/area/?language=$lang',
          );
      List<AreaModel> responseList = [];
      for (var area in response) {
        responseList.add(AreaModel.fromJson(area));
      }
      print(responseList.length);
      return right(responseList);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, String>> sendAddPostPlace(
      {required FormData data}) async {
    try {
      var response =
          await getIt.get<ApiService>().post(endPoint: '/places', data: data);
      return right(response['message']);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, String>> sendAddPostService(
      {required FormData data}) async {
    try {
      var response =
          await getIt.get<ApiService>().post(endPoint: '/services', data: data);
      // todo : we have to check of this line is correct or not
      return right(response['message']);
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print('Dio Exception');
          print(e.type);
        }
        return left(ServerFailure.fromDioError(e));
      }
      if (kDebugMode) {
        print('un expected error');
      }
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, String>> editPostPlace(
      {required FormData data, required int placeId}) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .post(endPoint: '/places/$placeId', data: data);
      // todo : we have to check of this line is correct or not
      return right(response['message']);
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print('Dio Exception');
          print(e.type);
        }
        return left(ServerFailure.fromDioError(e));
      }
      if (kDebugMode) {
        print('un expected error');
      }
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, String>> editPostService(
      {required FormData data, required int serviceId}) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .post(endPoint: '/services/$serviceId', data: data);
      // todo : we have to check of this line is correct or not
      return right(response['message']);
    } catch (e) {
      if (e is DioException) {
        if (kDebugMode) {
          print('Dio Exception');
          print(e.type);
        }
        return left(ServerFailure.fromDioError(e));
      }
      if (kDebugMode) {
        print('un expected error');
      }
      return left(ServerFailure(e.toString(), 600));
    }
  }
}
