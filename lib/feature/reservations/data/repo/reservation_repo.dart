import 'package:dartz/dartz.dart';
import 'package:sahab/feature/reservations/data/model/place_reservation_data_model.dart';
import 'package:sahab/feature/reservations/data/model/place_reservation_details_model.dart';
import 'package:sahab/feature/reservations/data/model/service_reservation_data_model.dart';
import 'package:sahab/feature/reservations/data/model/service_reservation_details_model.dart';

import '../../../../core/errors/failures.dart';

abstract class ReservationRepo {
  Future<Either<Failure, List<ServiceReservationDataModel>>>
      fetchReservationServiceData(context);
  Future<Either<Failure, List<PlaceReservationDataModel>>>
      fetchReservationPlaceData(context);
  Future<Either<Failure, PlaceReservationDetailsModel>>
      fetchReservationPlaceDetails(context, {required int id});
  Future<Either<Failure, ServiceReservationDetailsModel>>
      fetchReservationServiceDetails(context, {required int id});
  Future<Either<Failure, String>> cancelBooking(
      {required int id, required Map<String, String> data});
}
