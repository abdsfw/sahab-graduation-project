import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/auth/data/models/skip_model.dart';
import 'package:sahab/feature/auth/data/repositories/auth_repo.dart';

part 'skip_state.dart';

class SkipCubit extends Cubit<SkipState> {
  SkipCubit() : super(SkipInitial());
  Future<void> getSkipPhoto(context) async {
    emit(LoadingGetPhotoState());
    var result = await getIt.get<AuthRepo>().getSkipPhoto();
    result.fold((failure) {
      debugPrint('failure.errMassage: ${failure.errMassage}');
      emit(FailureGetPhotoState(failure.errMassage));
    }, (skipData) {
      // serviceData = serviceDataList;

      emit(SuccessGetPhotoState(skipData));
    });
  }
}
