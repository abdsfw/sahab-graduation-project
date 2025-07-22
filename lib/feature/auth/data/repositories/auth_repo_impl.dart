import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/auth/data/models/login_model/login_model.dart';
import 'package:sahab/feature/auth/data/models/new_login_model/new_login_model.dart';
import 'package:sahab/feature/auth/data/models/register/register_model.dart';
import 'package:sahab/feature/auth/data/models/skip_model.dart';
import 'package:sahab/feature/auth/data/repositories/auth_repo.dart';
import 'package:sahab/feature/auth/presentation/manager/cubit/login_cubit/cubit/login_cubit.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, NewRegisterModel>> register(User user) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .post(endPoint: "/users", data: user.toJson(), isLogin: true);
      NewRegisterModel userInfo = NewRegisterModel();
      if (response["user"] != null && response["token"] != null) {
        print(userInfo.token.toString());
        userInfo = NewRegisterModel.fromJson(response);
        await LoginCubit().storeUserInfo(userInfo);
        return right(userInfo);
      } else {
        return right(userInfo);
      }
    } catch (e) {
      if (e is DioException) {
        print(' ########### Dio Exception #################');
        print(e);
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString(), 500));
    }
  }

  @override
  Future<Either<Failure, NewLoginModel>> login(LoginModel user) async {
    try {
      final response = await getIt
          .get<ApiService>()
          .post(endPoint: "/users/login", data: user.toJson());
      NewLoginModel userInfo = NewLoginModel.fromJson(response);
      return right(userInfo);
    } catch (e) {
      print(e);
      if (e is DioException) {
        print(' ########### Dio Exception #################');
        print(e);
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString(), 500));
    }
  }

  @override
  Future<Either<Failure, String>> sendOtp(Map<String, dynamic> data) async {
    try {
      await getIt
          .get<ApiService>()
          .post(endPoint: "/users/get-otp", data: data);
      return right("sended");
    } catch (e) {
      print(e);
      if (e is DioException) {
        print(' ########### Dio Exception #################');
        print(e);
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString(), 500));
    }
  }

  @override
  Future<Either<Failure, String>> reSendOtp(Map<String, dynamic> data) async {
    try {
      await getIt
          .get<ApiService>()
          .post(endPoint: "/users/resend-otp", data: data);
      return right("Resend Ok");
    } catch (e) {
      print(e);
      if (e is DioException) {
        print(' ########### Dio Exception #################');
        print(e);
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString(), 500));
    }
  }

  @override
  Future<Either<Failure, Tuple2<NewLoginModel, bool>>> loginWithOtp(
      Map<String, dynamic> data) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .post(endPoint: "/users/login", data: data);
      // print(data);
      NewLoginModel userInfo = NewLoginModel();
      bool isRegister = response['is_registered'];
      if (response["message"] != null && response["token"] != null) {
        userInfo = NewLoginModel.fromJson(response);
        await LoginCubit().storeUserInfo(userInfo);
        return right(Tuple2(userInfo, isRegister));
      } else {
        return right(Tuple2(userInfo, isRegister));
      }
    } catch (e) {
      print(e);
      if (e is DioException) {
        print(' ########### Dio Exception #################');
        print(e);
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString(), 500));
    }
  }

  @override
  Future<Either<Failure, SkipModel>> getSkipPhoto() async {
    try {
      var response = await getIt.get<ApiService>().get(endPoint: "/Ad-popup");
      SkipModel skipModel = SkipModel.fromJson(response);
      return right(skipModel);
    } catch (e) {
      print(e);
      if (e is DioException) {
        print(' ########### Dio Exception #################');
        print(e);
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString(), 500));
    }
  }
}
