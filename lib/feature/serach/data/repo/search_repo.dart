import 'package:dartz/dartz.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/feature/serach/data/model/search_services_model.dart';
import 'package:sahab/feature/serach/data/model/serach_place_model.dart';
import 'package:sahab/feature/services/data/model/service.dart';

abstract class SearchRepo {
  Future<Either<Failure, Tuple2<List<SearchPlaceModel>, num>>>
      fetchSearchPlaces(String searchQuery, {String? query});
  Future<Either<Failure, Tuple2<List<Services>, num>>> fetchSearchServices(
      String searchQuery,
      {String? query});
}
