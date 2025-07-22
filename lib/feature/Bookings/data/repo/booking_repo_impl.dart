import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/Bookings/data/model/booking_details_place_model/booking_details_place_model.dart';
import 'package:sahab/feature/Bookings/data/model/booking_details_service_model/booking_details_service_model.dart';
import 'package:sahab/feature/Bookings/data/model/place_booking_data_model.dart';
import 'package:sahab/feature/Bookings/data/model/service_booking_data_model.dart';
import 'package:sahab/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';

import 'booking_repo.dart';

class BookingRepoImpl extends BookingRepo {
  @override
  Future<Either<Failure, String>> postRatingServiceAndPlace(
      Map<String, dynamic> data) async {
    try {
      var response = await getIt.get<ApiService>().post(
            endPoint: '/ratings',
            data: data,
          );
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
  Future<Either<Failure, List<PlaceBookingDataModel>>> fetchBookingPlaceData(
      context,
      {CancelToken? cancelToken}) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt.get<ApiService>().get(
          endPoint: '/users/places/bookings/get-all?language=$lang',
          cancelToken: cancelToken);
      List<PlaceBookingDataModel> listResponse = [];
      for (var placeData in response) {
        listResponse.add(PlaceBookingDataModel.fromJson(placeData));
      }
      return right(listResponse);
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
  Future<Either<Failure, List<ServiceBookingDataModel>>>
      fetchBookingServiceData(context) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt
          .get<ApiService>()
          .get(endPoint: '/users/services/bookings/get-all?language=$lang');
      // print(response);
      List<ServiceBookingDataModel> listResponse = [];
      for (var placeData in response) {
        listResponse.add(ServiceBookingDataModel.fromJson(placeData));
      }
      return right(listResponse);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error $e');
      return left(ServerFailure(e.toString(), 600));
    }
  }

  // @override
  // Future<Either<Failure, BookingDetailsModel>> fetchBookingDetails(context,
  //     {required int id}) async {
  //   try {
  //     String lang = BlocProvider.of<LangCubit>(context).lang;

  //     var response = await getIt
  //         .get<ApiService>()
  //         .get(endPoint: '/users/bookings/$id?language=$lang');
  //     BookingDetailsModel bookingDetails =
  //         BookingDetailsModel.fromJson(response);

  //     return right(bookingDetails);
  //   } catch (e) {
  //     if (e is DioException) {
  //       print('Dio Exception');
  //       print(e.type);
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     print('un expected error $e');
  //     return left(ServerFailure(e.toString(), 600));
  //   }
  // }

  @override
  Future<Either<Failure, BookingDetailsPlaceModel>> fetchBookingPlaceDetails(
      context,
      {required int id}) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt
          .get<ApiService>()
          .get(endPoint: '/users/bookings/$id?language=$lang');
      BookingDetailsPlaceModel bookingDetails =
          BookingDetailsPlaceModel.fromJson(response);

      return right(bookingDetails);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error $e');
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, BookingDetailsServiceModel>>
      fetchBookingServiceDetails(context, {required int id}) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt
          .get<ApiService>()
          .get(endPoint: '/users/bookings/$id?language=$lang');
      BookingDetailsServiceModel bookingDetails =
          BookingDetailsServiceModel.fromJson(response);

      return right(bookingDetails);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error $e');
      return left(ServerFailure(e.toString(), 600));
    }
  }
}
