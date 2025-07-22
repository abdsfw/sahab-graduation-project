import 'package:dartz/dartz.dart';
import 'package:sahab/feature/services/data/model/service.dart';
import 'package:sahab/feature/services/data/model/service_details_model/service_details_model.dart';

import '../../../../core/errors/failures.dart';
import '../model/service_model.dart';

abstract class ServicesRepo {
  Future<Either<Failure, List<ServicesModel>>> fetchServices();
  Future<Either<Failure, Tuple2<List<Services>, Map<String, num>>>>
      fetchServicesForOneCategory(
          {int pageNumber = 1, required int categoryId, String? query});
  Future<Either<Failure, ServiceDetailsModel>> fetchServiceDetailsByID(context,
      {required int ID});
  Future<Either<Failure, dynamic>> fetchServiceDates({required int serviceId});
}
