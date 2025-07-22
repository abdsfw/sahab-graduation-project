import 'package:dartz/dartz.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/feature/account/data/model/place_post_details_model/place_post_details_model.dart';
import 'package:sahab/feature/account/data/model/service_model/service_model.dart';
import 'package:sahab/feature/account/data/model/static_content_model.dart';
import 'package:sahab/feature/account/data/model/static_vendor_value_model/static_vendor_value.dart';
import 'package:sahab/feature/account/data/model/vendor_place_post_model/vendor_place_post_model.dart';
import 'package:sahab/feature/account/data/model/vendor_service_post_model/vendor_service_post_model.dart';

abstract class AccountRepo {
  Future<Either<Failure, String>> terminateAccount();
  Future<Either<Failure, String>> editAccount({
    required String name,
    required String email,
    required String phone,
    required String imagePath,
  });
  Future<Either<Failure, PlacePostDetailsModel>> fetchPlaceDetails(context,
      {required int placeId});
  Future<Either<Failure, String>> deletePlace({required int placeId});
  Future<Either<Failure, ServiceModel>> fetchServiceDetails(context,
      {required int serviceId});
  Future<Either<Failure, String>> deleteService({required int serviceId});
  Future<Either<Failure, StaticVendorValue>> fetchVendorStaticValue();
  Future<Either<Failure, List<VendorPlacePostModel>>> fetchVendorPlacePost(
      context);
  Future<Either<Failure, List<VendorServicePostModel>>> fetchVendorServicePost(
      context);
  Future<Either<Failure, String>> fetchStaticPage(String title);
  Future<Either<Failure, String>> sendMessage(Map<String, dynamic> data);
  Future<Either<Failure, List<StaticContentModel>>> fetchAllStaticPage();
  // Future<Either<Failure, StaticValue>> fetchStaticValue();
}
