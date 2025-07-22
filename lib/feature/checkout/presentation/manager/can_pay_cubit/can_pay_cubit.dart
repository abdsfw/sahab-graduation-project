import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/feature/checkout/presentation/manager/checkout_cubit/checkout_cubit.dart';

part 'can_pay_state.dart';

class CanPayCubit extends Cubit<CanPayState> {
  CanPayCubit() : super(CanPayInitial());
  static CanPayCubit get(context) => BlocProvider.of(context);
  void canPay(context) {
    var cubit = CheckoutCubit.get(context);
    if (cubit.nameController.text.isNotEmpty &&
        cubit.phoneController.text.isNotEmpty &&
        cubit.selectedPaymentMethod != null) {
      emit(CanCompletePayState());
    } else {
      emit(CanNotCompletePayState());
    }
  }
}
