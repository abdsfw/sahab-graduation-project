import 'package:dartz/dartz.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/feature/checkout/data/model/add_booking_response_model/add_booking_response_model.dart';
import 'package:sahab/feature/checkout/data/model/payment_method.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, List<PaymentMethod>>> fetchPaymentMethods();
  Future<Either<Failure, num>> applyPromoCode(
      {required Map<String, String> data});
  Future<Either<Failure, AddBookingResponseModel>> addBooking(
      {required Map<String, dynamic> data});
}
