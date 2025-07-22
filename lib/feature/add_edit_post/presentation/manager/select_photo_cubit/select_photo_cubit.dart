import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahab/core/enums/type_post_enum.dart';
import 'package:sahab/core/utils/functions/function.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/next_post_service_cubit/next_post_service_cubit.dart';
import 'package:sahab/generated/l10n.dart';

part 'select_photo_state.dart';

class SelectPhotoCubit extends Cubit<SelectPhotoState> {
  SelectPhotoCubit() : super(SelectPhotoInitial());
  static SelectPhotoCubit get(context) => BlocProvider.of(context);

  List<String> selectedImagePathList = [
    /*
    ! this init string in this List 
    ! because we have button at first of grid view
    ! thar make us selected new image `picker`
    */
    "string_of_selected_button",
  ];
  int selectedDeleteIndex = -1;
  List<File> imageFile = [];

  void deleteSelectedImage(int index, context, {required TypeToggle typePost}) {
    selectedDeleteIndex = -1;
    selectedImagePathList.removeAt(index);
    imageFile.removeAt(index - 1);
    switch (typePost) {
      case TypeToggle.service:
        BlocProvider.of<NextPostServiceCubit>(context).checkIfCanMove(context);
        break;
      case TypeToggle.place:
        BlocProvider.of<NextPostPlaceCubit>(context).checkIfCanMove(context);
        break;
    }

    emit(DeleteSelectPhotoState());
  }

  void addSelectedImage(context, {required TypeToggle typePost}) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      print(image.path);
      if (!checkIfValidPhoto(image.path)) {
        await AppFunction.confirmDialog(
          context,
          title: S.of(context).invalid_format,
          onYesTap: () {
            Navigator.of(context).pop();
          },
        );
        return;
      }
      selectedImagePathList.add(image.path);
      imageFile.add(File(image.path));
      emit(AddSelectPhotoState());

      switch (typePost) {
        case TypeToggle.service:
          BlocProvider.of<NextPostServiceCubit>(context)
              .checkIfCanMove(context);
          break;
        case TypeToggle.place:
          BlocProvider.of<NextPostPlaceCubit>(context).checkIfCanMove(context);
          break;
      }
    }
  }

  bool checkIfValidPhoto(String path) {
    if (path.endsWith(".jpg") ||
        path.endsWith(".JPG") ||
        path.endsWith(".png") ||
        path.endsWith(".PNG") ||
        path.endsWith(".jpeg") ||
        path.endsWith(".JPEG")) {
      return true;
    } else {
      return false;
    }
  }

  void removeDeleteMode() {
    selectedDeleteIndex = -1;
    emit(SelectPhotoInitial());
  }

  void selectPhotoIndex(int index) {
    selectedDeleteIndex = index;
    emit(SelectDeleteModePhotoState());
  }

  void clearCubitData() {
    selectedDeleteIndex = -1;
    selectedImagePathList = [
      "string_of_selected_button",
    ];
    imageFile.clear();
  }
}
