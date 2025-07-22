import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab/feature/auth/data/models/register/register_model.dart';
import 'package:sahab/feature/auth/data/repositories/auth_repo.dart';

import '../login_cubit/cubit/login_cubit.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
//! -------------- Var ----------------------

  static RegisterCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> registererFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  // ! ----------------- functions --------------------
  //*  Function to handle registration process
  Future<void> register(BuildContext context) async {
    if (!registererFormKey.currentState!.validate()) {
      return;
    }
    User newUser = User(
        userName: name.text.trim(),
        email: email.text,
        phone: BlocProvider.of<LoginCubit>(context).numberController.text);
    emit(RegisterLoading());
    print(newUser.toJson());
    //* Get authentication repository instance
    Either<Failure, void> result =
        await getIt.get<AuthRepo>().register(newUser);
    result.fold((error) => emit(RegisterError(errMessage: error.errMassage)),
        (_) {
      BlocProvider.of<AccountCubit>(context).setUserInfo();
      CacheHelper.setData(key: Constant.kIsRegister, value: true);
      emit(RegisterSuccess());
    });
  }
}
