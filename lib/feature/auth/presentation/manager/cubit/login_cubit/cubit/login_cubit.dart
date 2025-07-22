import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/auth/data/models/login_model/login_model.dart';
import 'package:sahab/feature/auth/data/repositories/auth_repo.dart';

import '../../../../../data/models/new_login_model/new_login_model.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  // ! -------- Var -----------------
  static LoginCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  //! ------------ functions -------------------
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    emit(LoginLoading());
    LoginModel newLogin = LoginModel(phone: numberController.text);

    var result = await getIt.get<AuthRepo>().login(newLogin);
    result.fold((error) {
      emit(LoginFailure(error.errMassage));
    }, (userInfo) async {
      await storeUserInfo(userInfo);
      emit(LoginSuccess());
    });
  }

  Future<void> sendOtp() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    emit(LoginLoading());
    print("data");
    print({"phone": numberController.text});
    var result =
        await getIt.get<AuthRepo>().sendOtp({"phone": numberController.text});
    result.fold((error) {
      emit(LoginFailure(error.errMassage));
    }, (send) {
      emit(LoginSuccess());
    });
  }

  Future storeUserInfo(var userInfo) async {
    await CacheHelper.setData(
      key: Constant.kUserId,
      value: userInfo.message?.id ?? 0,
    );
    await CacheHelper.setData(
      key: Constant.kUserName,
      value: userInfo.message?.name ?? 'null',
    );
    await CacheHelper.setData(
      key: Constant.kUserPhoneNumber,
      value: userInfo.message?.phone ?? 'null',
    );
    await CacheHelper.setData(
      key: Constant.kUserRole,
      value: userInfo.message?.role ?? 'null',
    );
    await CacheHelper.setData(
      key: Constant.kUserEmail,
      value: userInfo.message?.email ?? 'null',
    );
    await CacheHelper.setData(
      key: Constant.kUserImage,
      value: userInfo.message?.image ?? 'null',
    );
    await CacheHelper.setData(
      key: Constant.kToken,
      value: userInfo.token ?? 'null',
    );
  }
}
