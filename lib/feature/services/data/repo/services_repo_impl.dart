import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:sahab/feature/services/data/model/service.dart';
import 'package:sahab/feature/services/data/model/service_details_model/service_details_model.dart';
import 'package:sahab/feature/services/data/model/service_model.dart';
import 'package:sahab/feature/services/data/repo/services_repo.dart';

class ServicesRepoImpl implements ServicesRepo {
  final String servicesEndPoint = '/services';
  @override
  Future<Either<Failure, List<ServicesModel>>> fetchServices() async {
    try {
      var response =
          await getIt.get<ApiService>().get(endPoint: servicesEndPoint);
      List<ServicesModel> servicesList = [];
      for (var serviceItem in response) {
        servicesList.add(ServicesModel.fromJson(serviceItem));
      }
      log("Fetch Service Success there are ${servicesList.length} service");
      return Right(servicesList);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetch Service` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, Tuple2<List<Services>, Map<String, num>>>>
      fetchServicesForOneCategory(
          {int pageNumber = 0, required int categoryId, String? query}) async {
    try {
      List<Services> servicesList = [];
      var response;
      if (query != null) {
        response = await getIt.get<ApiService>().get(
            endPoint:
                "/categories/$categoryId/services/?page=$pageNumber&per_page=5&$query");
      } else {
        response = await getIt.get<ApiService>().get(
            endPoint:
                "/categories/$categoryId/services/?page=$pageNumber&per_page=5");
      }
      for (var place in response['data']['services']['data']) {
        servicesList.add(Services.fromJson(place));
      }
      Map<String, num> importantData = {};
      int totalCount =
          int.tryParse(response['data']["services"]['total'].toString()) ?? 0;
      importantData["total"] = totalCount;
      // importantData.add(totalCount);
      num maxPrice =
          num.tryParse(response['data']['max_price'].toString()) ?? 0;
      importantData["max_price"] = maxPrice;
      log("Fetch Services Success there are ${servicesList.length} places");
      return right(Tuple2(servicesList, importantData));
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetch Services For category` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error $e");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, ServiceDetailsModel>> fetchServiceDetailsByID(context,
      {required int ID}) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt
          .get<ApiService>()
          .get(endPoint: "/services/$ID?language=$lang");
      ServiceDetailsModel details = ServiceDetailsModel.fromJson(response);
      return Right(details);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetchServiceDetailsByID` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error $e");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchServiceDates(
      {required int serviceId}) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .get(endPoint: "/services/$serviceId/bookings");

      return right(response);
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
}
