import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/enums/type_post_enum.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/extension/date_time_extension.dart';
import 'package:sahab/feature/checkout/data/model/add_booking_response_model/add_booking_response_model.dart';
import 'package:sahab/feature/checkout/data/model/payment_method.dart';
import 'package:sahab/feature/checkout/data/repo/checkout_repo.dart';
import 'package:sahab/feature/checkout/presentation/manager/can_pay_cubit/can_pay_cubit.dart';
import 'package:sahab/feature/checkout/presentation/manager/promo_code_cubit/promo_code_cubit.dart';

import '../../../../../core/utils/service_locator.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  static CheckoutCubit get(context) => BlocProvider.of(context);
  num price = 0;
  num discountPrice = 0;
  String? promoCode;
  num totalPrice = 0;
  int id = -1;
  String? address;
  DateTime? startDate;
  DateTime? endDate;
  PaymentMethod? selectedPaymentMethod;
  TextEditingController nameController =
      TextEditingController(text: CacheHelper.getData(key: Constant.kUserName));
  TextEditingController phoneController = TextEditingController(
      text: CacheHelper.getData(key: Constant.kUserPhoneNumber));

  AddBookingResponseModel? bookingResponse;

  void setImportantAttribute(
    context, {
    required num price,
    required DateTime startDate,
    required DateTime endDate,
    required int id,
    String? address,
  }) {
    this.id = id;
    this.startDate = startDate;
    this.endDate = endDate;
    this.price = price;
    this.address = address;
    print(startDate);
    print(endDate);
    print(price);
    print(address);
    totalPrice = price;
    discountPrice =
        (BlocProvider.of<PromoCodeCubit>(context).amountOfDiscount / 100) *
            totalPrice;
    totalPrice -= discountPrice;
  }

  void selectPaymentMethod(int paymentId, context) {
    if (paymentId == selectedPaymentMethod?.id) {
      return;
    }
    selectedPaymentMethod = PaymentMethod(id: paymentId);
    emit(CheckoutInitial());
    BlocProvider.of<CanPayCubit>(context).canPay(context);
  }

  Future<void> addBooking({required TypeToggle typeToggle}) async {
    var data;
    if (typeToggle == TypeToggle.place) {
      data = {
        "starting_date":
            DateFormat("yyyy-MM-dd", "en").format(startDate!), //"2024-04-26",
        "ending_date":
            DateFormat("yyyy-MM-dd", "en").format(endDate!), // "2024-04-27",
        "payment_method_id": selectedPaymentMethod?.id ?? -1,
        "place_id": id,
        "code": promoCode,
        "total_price": totalPrice
      };
    } else {
      DateTime start = startDate ?? DateTime.now();
      DateTime end = endDate ?? DateTime.now();
      data = {
        "date": DateFormat("yyyy-MM-dd", "en").format(startDate!),
        "starting_time": start.hourMinuteSecond(),
        "ending_time": end.hourMinuteSecond(),
        "payment_method_id": selectedPaymentMethod?.id ?? -1,
        "code": promoCode,
        "service_id": id,
        "address": address,
        "total_price": totalPrice
      };
    }
    print(data);
    emit(LoadingCheckoutState());
    var result = await getIt.get<CheckoutRepo>().addBooking(data: data);
    result.fold((error) {
      emit(FirstFailureCheckoutState(error.errMassage));
    }, (addBookingResponse) {
      this.bookingResponse = addBookingResponse;
      emit(FirstSuccessCheckoutState(addBookingResponse));
    });
  }

  void setDiscountAmount(num discount, String promoCode) {
    discountPrice = totalPrice * (discount / 100);
    this.promoCode = promoCode;
    totalPrice -= discountPrice;
  }
}
