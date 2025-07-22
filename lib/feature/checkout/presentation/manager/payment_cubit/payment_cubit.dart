import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/checkout/data/model/payment_method.dart';
import 'package:sahab/feature/checkout/data/repo/checkout_repo.dart';

import '../../../../../core/utils/cache/cache_helper.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of<PaymentCubit>(context);
  List<PaymentMethod> paymentMethodList = [];
  Future<void> fetchPaymentMethod() async {
    emit(LoadingFetchPaymentState());
    var result = await getIt.get<CheckoutRepo>().fetchPaymentMethods();
    result.fold((error) {
      emit(FailureFetchPaymentState(error.errMassage));
    }, (paymentMethod) {
      paymentMethodList = paymentMethod;
      emit(SuccessFetchPaymentState(paymentMethod));
    });
  }
}
