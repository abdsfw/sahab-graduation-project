import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:sahab/feature/reservations/data/model/place_reservation_data_model.dart';
import 'package:sahab/feature/reservations/data/model/place_reservation_details_model.dart';
import 'package:sahab/feature/reservations/data/model/service_reservation_data_model.dart';
import 'package:sahab/feature/reservations/data/model/service_reservation_details_model.dart';
import 'package:sahab/feature/reservations/data/repo/reservation_repo.dart';

class ReservationRepoImpl extends ReservationRepo {
  @override
  Future<Either<Failure, List<PlaceReservationDataModel>>>
      fetchReservationPlaceData(context) async {
    try {
      print("dsf");
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt
          .get<ApiService>()
          .get(endPoint: '/users/places/reservations/get-all?language=$lang');
      print("dsf2222");
      List<PlaceReservationDataModel> listResponse = [];
      for (var placeData in response) {
        listResponse.add(PlaceReservationDataModel.fromJson(placeData));
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
  Future<Either<Failure, List<ServiceReservationDataModel>>>
      fetchReservationServiceData(context) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt
          .get<ApiService>()
          .get(endPoint: '/users/services/reservations/get-all?language=$lang');
      List<ServiceReservationDataModel> listResponse = [];
      for (var placeData in response) {
        listResponse.add(ServiceReservationDataModel.fromJson(placeData));
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

  @override
  Future<Either<Failure, PlaceReservationDetailsModel>>
      fetchReservationPlaceDetails(context, {required int id}) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt
          .get<ApiService>()
          .get(endPoint: '/users/reservations/$id?language=$lang');
      print("hiiii");
      PlaceReservationDetailsModel responseModel =
          PlaceReservationDetailsModel.fromJson(response);

      return right(responseModel);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error$e');
      print(e.toString());
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, ServiceReservationDetailsModel>>
      fetchReservationServiceDetails(context, {required int id}) async {
    try {
      String lang = BlocProvider.of<LangCubit>(context).lang;

      var response = await getIt
          .get<ApiService>()
          .get(endPoint: '/users/reservations/$id?language=$lang');
      ServiceReservationDetailsModel responseModel =
          ServiceReservationDetailsModel.fromJson(response);
      return right(responseModel);
    } catch (e) {
      if (e is DioException) {
        print('Dio Exception');
        print(e.type);
        return left(ServerFailure.fromDioError(e));
      }
      print('un expected error$e');
      return left(ServerFailure(e.toString(), 600));
    }
  }

  @override
  Future<Either<Failure, String>> cancelBooking(
      {required int id, required Map<String, String> data}) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .put(endPoint: '/bookings/$id', data: data);

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
}
