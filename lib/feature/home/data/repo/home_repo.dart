import 'package:dartz/dartz.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/feature/home/data/model/user_check_model.dart';

import '../../../places/data/model/place_details_model/place_image.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<PlaceImage>>> getHomePic();
  Future<Either<Failure, String>> sendToken(Map<String, dynamic> data);
  Future<Either<Failure, UserCheckModel>> checkUserRole();
  Future<dynamic> fetchSvgData({required String url});
}
