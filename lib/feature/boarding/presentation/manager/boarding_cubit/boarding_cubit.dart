import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/const.dart';

import '../../../../../core/utils/cache/cache_helper.dart';

part 'boarding_state.dart';

class BoardingCubit extends Cubit<BoardingState> {
  BoardingCubit() : super(BoardingInitial());

  // -------------------- VAR ---------------------

  bool isSkip = true;

  // ----------------------------------------------

  void changeSplashScreen() async {
    await Future.delayed(
      const Duration(seconds: 5),
      () {
        emit(ChangeSplashScreenState());
      },
    );
  }

  void changeSkipScreen() {
    // ! here we should put in sharedPref thar we skip the skip screen and make the key `Constant.kisSkip` as true value
    CacheHelper.setData(key: Constant.kisSkip, value: true);

    emit(ChangeSkipScreenState());
  }
}
