import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/data/model/place_post_details_model/place_post_details_model.dart';
import 'package:sahab/feature/account/data/model/service_model/service_model.dart';
import 'package:sahab/feature/account/data/model/static_content_model.dart';
import 'package:sahab/feature/account/data/model/static_vendor_value_model/static_vendor_value.dart';
import 'package:sahab/feature/account/data/model/statistics_vendor_value/static_value.dart';
import 'package:sahab/feature/account/data/model/vendor_place_post_model/vendor_place_post_model.dart';
import 'package:sahab/feature/account/data/model/vendor_service_post_model/vendor_service_post_model.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';
import 'package:sahab/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';

class AccountRepoImpl implements AccountRepo {
  final String userEndPoint = '/users';
  // final int? _userId = CacheHelper.getData(key: Constant.kUserId);
  @override
  Future<Either<Failure, String>> terminateAccount() async {
    try {
      await getIt.get<ApiService>().delete(
          endPoint: "$userEndPoint/",
          id: CacheHelper.getData(key: Constant.kUserId));
      return right("Account terminated");
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `terminated` method $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, String>> editAccount(
      {required String name,
      required String email,
      required String phone,
      required String imagePath}) async {
    try {
      FormData formData = FormData();
      formData.fields.add(MapEntry('phone', phone));
      formData.fields.add(MapEntry('email', email));
      formData.fields.add(MapEntry('name', name));
      if (imagePath.isNotEmpty) {
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(imagePath),
        ));
      }
      // formData.files.add(MapEntry(
      //   'image',
      //   await MultipartFile.fromFile(imagePath),
      // ));

      if (kDebugMode) {
        print('FormData fields:');
        print(imagePath);
        print("$userEndPoint/${CacheHelper.getData(key: Constant.kUserId)}");
      }

      formData.fields.forEach((entry) {
        print('${entry.key}: ${entry.value}');
      });
      var response = await getIt.get<ApiService>().post(
          endPoint:
              "$userEndPoint/${CacheHelper.getData(key: Constant.kUserId)}",
          data: formData);
      print(response);

      return right(response['user']['image']);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `edit Profile` method $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error $e");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, PlacePostDetailsModel>> fetchPlaceDetails(context,
      {required int placeId}) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt.get<ApiService>().get(
            endPoint: '/places/$placeId?language=$lang',
          );
      PlacePostDetailsModel responseModel =
          PlacePostDetailsModel.fromJson(response);
      return right(responseModel);
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
  Future<Either<Failure, String>> deletePlace({required int placeId}) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .delete(endPoint: '/places/', id: placeId);

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
  Future<Either<Failure, String>> deleteService(
      {required int serviceId}) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .delete(endPoint: '/services/', id: serviceId);

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
  Future<Either<Failure, ServiceModel>> fetchServiceDetails(context,
      {required int serviceId}) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt.get<ApiService>().get(
            endPoint: '/services/$serviceId?language=$lang',
          );
      ServiceModel responseModel = ServiceModel.fromJson(response);
      return right(responseModel);
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
  Future<Either<Failure, StaticVendorValue>> fetchVendorStaticValue() async {
    try {
      dynamic response =
          await getIt.get<ApiService>().get(endPoint: "/users/statistics");
      StaticVendorValue responseModel = StaticVendorValue.fromJson(response);
      return right(responseModel);
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
  Future<Either<Failure, List<VendorPlacePostModel>>> fetchVendorPlacePost(
      context) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      dynamic response = await getIt
          .get<ApiService>()
          .get(endPoint: "/users/places/get-all?language=$lang");
      List<VendorPlacePostModel> responseList = [];
      for (var place in response) {
        responseList.add(VendorPlacePostModel.fromJson(place));
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
  Future<Either<Failure, List<VendorServicePostModel>>> fetchVendorServicePost(
      context) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt
          .get<ApiService>()
          .get(endPoint: "/users/services/get-all?language=$lang");
      List<VendorServicePostModel> responseList = [];
      for (var service in response) {
        responseList.add(VendorServicePostModel.fromJson(service));
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
  Future<Either<Failure, String>> fetchStaticPage(String title) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .get(endPoint: "/static-contents/get?title=$title");
      String content = '';
      if (response['content'] != null) {
        content = response['content'];
      } else {
        content = "";
      }
      return right(content);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      print(e);
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, String>> sendMessage(Map<String, dynamic> data) async {
    try {
      await getIt
          .get<ApiService>()
          .post(endPoint: "/contact-requests", data: data);
      return right("Send");
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      print(e);
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, List<StaticContentModel>>> fetchAllStaticPage() async {
    try {
      var response =
          await getIt.get<ApiService>().get(endPoint: "/static-contents");
      List<StaticContentModel> listDAta = [];
      for (var element in response) {
        listDAta.add(StaticContentModel.fromJson(element));
      }
      return right(listDAta);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error');
      print(e);
      return left(ServerFailure(e.toString(), 600));
    }
  }

  // @override
  // Future<Either<Failure, StaticValue>> fetchStaticValue() async {
  //   try {
  //     var response = await getIt.get<ApiService>().get(endPoint: "statistics");
  //     return right(response);
  //   } catch (e) {
  //     if (e is DioException) {
  //       print('Dio Exception');
  //       print(e.type);
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     print('un expected error');
  //     print(e);
  //     return left(ServerFailure(e.toString(), 600));
  //   }
  // }
}
