import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/feature/Bookings/data/model/booking_details_place_model/booking_details_place_model.dart';
import 'package:sahab/feature/Bookings/data/model/booking_details_service_model/booking_details_service_model.dart';
import 'package:sahab/feature/Bookings/data/model/place_booking_data_model.dart';
import 'package:sahab/feature/Bookings/data/model/service_booking_data_model.dart';

abstract class BookingRepo {
  Future<Either<Failure, String>> postRatingServiceAndPlace(
    Map<String, dynamic> data,
  );
  Future<Either<Failure, List<ServiceBookingDataModel>>>
      fetchBookingServiceData(context);
  Future<Either<Failure, List<PlaceBookingDataModel>>> fetchBookingPlaceData(
      context,
      {CancelToken? cancelToken});
  Future<Either<Failure, BookingDetailsPlaceModel>> fetchBookingPlaceDetails(
    context, {
    required int id,
  });
  Future<Either<Failure, BookingDetailsServiceModel>>
      fetchBookingServiceDetails(
    context, {
    required int id,
  });
}
