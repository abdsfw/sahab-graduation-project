import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/checkout/data/model/add_booking_response_model/add_booking_response_model.dart';
import 'package:sahab/feature/checkout/data/model/payment_method.dart';
import 'package:sahab/feature/checkout/data/repo/checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  @override
  Future<Either<Failure, List<PaymentMethod>>> fetchPaymentMethods() async {
    try {
      var response =
          await getIt.get<ApiService>().get(endPoint: "/payment-methods");
      List<PaymentMethod> listData = [];
      for (var method in response) {
        listData.add(PaymentMethod.fromJson(method));
      }
      return right(listData);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `fetchPaymentMethods in checkout repo` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error $e");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, num>> applyPromoCode(
      {required Map<String, String> data}) async {
    try {
      var response = await getIt.get<ApiService>().put(
            endPoint: "/promo-codes/apply",
            data: data,
          );
      num amountOfDiscount = response["message"]["discount"] ?? 0;
      return right(amountOfDiscount);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `applyPromoCode` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, AddBookingResponseModel>> addBooking(
      {required Map<String, dynamic> data}) async {
    try {
      var response = await getIt.get<ApiService>().post(
            endPoint: "/bookings",
            data: data,
          );
      AddBookingResponseModel correctResponse =
          AddBookingResponseModel.fromJson(response);
      return right(correctResponse);
    } catch (e) {
      if (e is DioException) {
        log("dio Exception from `addBooking` method");
        log("this is the error $e");
        return left(ServerFailure.fromDioError(e));
      }
      log("un expected error");
      return left(ServerFailure(e.toString(), 600));
    }
  }
}
