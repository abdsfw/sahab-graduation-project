import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/notifiction/notification_cubit/notification_cubit.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab/feature/auth/data/repositories/auth_repo.dart';
import 'package:sahab/feature/auth/presentation/manager/cubit/login_cubit/cubit/login_cubit.dart';
import 'package:sahab/feature/auth/presentation/pages/register/register_screen.dart';
import 'package:sahab/feature/home/presentation/pages/home_page_view.dart';
import 'package:timer_count_down/timer_controller.dart';
part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  static OtpCubit get(context) => BlocProvider.of(context);
  CountdownController timerController = CountdownController(autoStart: true);
  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  TextEditingController fourth = TextEditingController();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  int timerSeconds = 120;
  void deleteController() {
    first.clear();
    second.clear();
    third.clear();
    fourth.clear();
  }

  void timerFished() {
    emit(OtpTimerFished());
  }

  Future<bool> otpInitial() async {
    timerController.pause();

    deleteController();

    emit(OtpInitial());
    return true;
  }

  void otpInitialInIcon(BuildContext context) {
    timerController.pause();
    deleteController();
    Navigator.of(context).pop();
    emit(OtpInitial());
  }

  void timerRest() {
    timerSeconds = 120;
    timerController.restart();
    emit(OtpTimerReset());
  }

  void handleFocusChange(bool hasFocus) {
    if (!hasFocus) {
      timerRest();
    }
  }

  Future<void> reSendOtp(BuildContext context) async {
    emit(ResendOtpLoading());
    var result = await getIt.get<AuthRepo>().sendOtp(
        {"phone": BlocProvider.of<LoginCubit>(context).numberController.text});
    result.fold((error) {
      emit(ResendOtpLFailure());

      print(error);
    }, (reSended) {
      timerRest();
      deleteController();
      emit(ResendOtpLSuccess());
    });
  }

  Future<void> loginWithOtp(BuildContext context, String code) async {
    if (!otpFormKey.currentState!.validate()) {
      return;
    }
    print(code);
    print(BlocProvider.of<LoginCubit>(context).numberController.text);
    var result = await getIt.get<AuthRepo>().loginWithOtp({
      "phone": BlocProvider.of<LoginCubit>(context).numberController.text,
      "code": code
    });
    result.fold((error) {
      print(error.errMassage);
      emit(OtpFailure());
    }, (login) async {
      BlocProvider.of<AccountCubit>(context).setAllUserInfo();
      if (login.value2) {
        BlocProvider.of<NotificationCubit>(context).sendNotificationToken();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => HomePageView(),
          ),
          (route) {
            return false;
          },
        );

        CacheHelper.setData(key: Constant.kIsRegister, value: true);
        deleteController();
        emit(OtpSuccess());
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RegisterScreen(),
          ),
          // (route) {
          //   return false;
          // },
        );

        deleteController();
        emit(OtpSuccess());
      }
    });
  }

  void timerStart() {
    timerSeconds = 120;
    timerController.start();
    emit(OtpInitial());
  }
}
