import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/feature/add_edit_post/data/model/amenity_model.dart';
import 'package:sahab/feature/add_edit_post/data/model/area_model.dart';

abstract class AddEditPostRepo {
  Future<Either<Failure, List<AmenityModel>>> fetchAllAmenity(context);
  Future<Either<Failure, String>> sendAddPostPlace({required FormData data});
  Future<Either<Failure, List<AreaModel>>> fetchAllArea(context);
  Future<Either<Failure, String>> sendAddPostService({required FormData data});
  Future<Either<Failure, String>> editPostService(
      {required FormData data, required int serviceId});
  Future<Either<Failure, String>> editPostPlace(
      {required FormData data, required int placeId});
}
