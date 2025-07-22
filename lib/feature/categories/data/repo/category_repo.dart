import 'package:dartz/dartz.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/feature/categories/data/model/category_model.dart';
import 'package:sahab/feature/places/data/model/place_model.dart';

abstract class CategoryRepo {
  Future<Either<Failure, List<CategoryModel>>> fetchHomeCategory(
      String type, context);
  Future<Either<Failure, Tuple2<List<PlaceModel>, Map<String, num>>>>
      fetchPlaceForOneCategory(
          {int pageNumber = 1, int categoryId, String? query});
}
