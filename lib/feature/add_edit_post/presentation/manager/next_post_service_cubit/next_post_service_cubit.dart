import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/select_photo_cubit/select_photo_cubit.dart';

part 'next_post_service_state.dart';

class NextPostServiceCubit extends Cubit<NextPostServiceState> {
  NextPostServiceCubit() : super(ServiceStepOnePostInitial());
  static NextPostServiceCubit get(context) => BlocProvider.of(context);

  //? ------------------------- step one controllers ----------------
  TextEditingController titleController = TextEditingController();
  String? selectServiceDropDown;
  TextEditingController aboutServiceController = TextEditingController();
  //? ----------------------------------------------------------------

  //? ------------------------- step two controllers -----------------
  TextEditingController durationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController noticePeriodController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  //? ----------------------------------------------------------------
  final PageController servicePageController = PageController();

  void checkIfCanMove(context) {
    print('check if can move');
    // if (formKey.currentState!.validate()) {
    //   emit(CanMovePostState());
    // } else {
    //   emit(CanNotMovePostState());
    // }
    // !  count of controllers that have a value
    // int count = 0;

    if (titleController.text.isEmpty) {
      emit(ServiceCanNotMovePostState());
      return;
    }
    if (selectServiceDropDown == null) {
      emit(ServiceCanNotMovePostState());
      return;
    }
    if (aboutServiceController.text.isEmpty) {
      emit(ServiceCanNotMovePostState());
      return;
    }
    if (BlocProvider.of<SelectPhotoCubit>(context).imageFile.isEmpty) {
      emit(ServiceCanNotMovePostState());
      return;
    }
    emit(ServiceCanMovePostState());
  }

  void checkIfCanPost() {
    if (durationController.text.isEmpty) {
      emit(ServiceStepTowPostState());
      return;
    }
    if (priceController.text.isEmpty) {
      emit(ServiceStepTowPostState());
      return;
    }
    if (noticePeriodController.text.isEmpty) {
      emit(ServiceStepTowPostState());
      return;
    }
    if (capacityController.text.isEmpty) {
      emit(ServiceStepTowPostState());
      return;
    }
    emit(CanPostState());
  }

  void navigateToNextPageView() {
    servicePageController.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
    emit(ServiceStepTowPostState());
    checkIfCanPost();
  }

  void navigateToPreviousPageView() {
    servicePageController.previousPage(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        emit(ServiceCanMovePostState());
      },
    );
  }

  void clearControllers() {
    titleController.clear();
    selectServiceDropDown = null;
    durationController.clear();
    noticePeriodController.clear();
    capacityController.clear();
    priceController.clear();
    aboutServiceController.clear();
    selectServiceDropDown = null;
    emit(ServiceStepOnePostInitial());
  }
}
