import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/checkout/data/repo/checkout_repo.dart';
import 'package:sahab/feature/checkout/presentation/manager/checkout_cubit/checkout_cubit.dart';

part 'promo_code_state.dart';

class PromoCodeCubit extends Cubit<PromoCodeState> {
  PromoCodeCubit() : super(PromoCodeInitial());
  static PromoCodeCubit get(context) => BlocProvider.of(context);
  TextEditingController promoCodeController = TextEditingController();
  num amountOfDiscount = 0;
  Future<void> applyPromoCode(context) async {
    Map<String, String> data = {"code": promoCodeController.text};
    emit(LoadingPromoCode());
    var result = await getIt.get<CheckoutRepo>().applyPromoCode(data: data);
    result.fold((error) {
      // promoCodeController.clear;
      emit(FailurePromoCode());
    }, (success) {
      amountOfDiscount = success;
      // promoCodeController.clear;
      BlocProvider.of<CheckoutCubit>(context)
          .setDiscountAmount(amountOfDiscount, promoCodeController.text);
      emit(SuccessPromoCode());
    });
  }

  void reset() {
    promoCodeController.clear();
    amountOfDiscount = 0;
    emit(PromoCodeInitial());
  }
}
