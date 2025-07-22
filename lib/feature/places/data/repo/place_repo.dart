import 'package:dartz/dartz.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/feature/places/data/model/featured_place/feature_place_model/feature_place_model.dart';
import 'package:sahab/feature/places/data/model/featured_place/featured_place.dart';
import 'package:sahab/feature/places/data/model/place_details_model.dart';
import 'package:sahab/feature/places/data/model/place_details_model/place_details_model.dart';
import '../model/place_model.dart';

abstract class PlaceRepo {
  // Future<Either<Failure, Tuple2<List<PlaceModel>, int>>> fetchHomePlaces(
  //     {int pageNumber = 0, String? query});
  Future<Either<Failure, PlaceDetailsModel>> fetchPlacesDetails(context,
      {required int placeId});
  Future<Either<Failure, List<PlaceModel>>> fetchAllPlaces();
  Future<Either<Failure, List<DateTime>>> fetchIgnoreDates(
      {required int placeId});
  Future<Either<Failure, Tuple2<List<FeaturePlaceModel>, num>>>
      fetchAllFuturePlaces(context, {String? query});
}
