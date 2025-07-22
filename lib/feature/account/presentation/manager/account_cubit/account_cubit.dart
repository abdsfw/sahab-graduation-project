import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/presentation/view/widgets/question_dialog.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';
import 'package:sahab/generated/l10n.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  // ? --------------------------------------------
  //! --------var-------------
  static AccountCubit get(context) => BlocProvider.of(context);
  File? selectedImage;
  bool anotherImage = false;
  String? userRole;
  int? userID;
  String? userName;
  String? userEmail;
  String? userPhone;
  bool isLoading = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  String? imagePath;
  //! --------EndVar-------------
// ? --------------------------------------------------
//! --------Functions-------------------------

  void setUserInfo() async {
    String? role = await CacheHelper.getData(key: Constant.kUserRole);

    if (role != userRole) {
      userRole = role;
      userID = await CacheHelper.getData(key: Constant.kUserId);
      userName = await CacheHelper.getData(key: Constant.kUserName);
      userEmail = await CacheHelper.getData(key: Constant.kUserEmail);
      userPhone = await CacheHelper.getData(key: Constant.kUserPhoneNumber);
      emit(StarEditAccount());
    }
  }

  void setAllUserInfo() async {
    userRole = await CacheHelper.getData(key: Constant.kUserRole);
    userID = await CacheHelper.getData(key: Constant.kUserId);
    userName = await CacheHelper.getData(key: Constant.kUserName);
    userEmail = await CacheHelper.getData(key: Constant.kUserEmail);
    userPhone = await CacheHelper.getData(key: Constant.kUserPhoneNumber);

    emit(StarEditAccount());
  }

  Future<void> getImage() async {
    // ! this function to get Image from Image picker
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      anotherImage = true;
      imagePath = selectedImage!.path;
      emit(AccountImageLoaded(selectedImage!));
    }
    // } else if (image != null && anotherImage) {
    //   selectedImage = File(image.path);
    //   anotherImage = false;
    //   imagePath = selectedImage!.path;
    //   emit(AccountAnotherImage(selectedImage!));
    // && !anotherImage
    // }
  }

  void getControllerValue() {
    // ! this Function to  init the  controller
    userNameController.text = CacheHelper.getData(key: Constant.kUserName);
    userEmailController.text = CacheHelper.getData(key: Constant.kUserEmail);
    userPhoneController.text =
        CacheHelper.getData(key: Constant.kUserPhoneNumber);
    emit(StarEditAccount());
  }

  Future<dynamic> showQuestionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return QuestionDialog(
          title: S.of(context).terminate_account,
          content: S.of(context).confirm_terminate_account_message,
        );
      },
    );
  }

  // Future<void> terminateAccount() async {
  //   emit(AccountTerminateLoading as AccountState);
  //   Either<Failure, String> result =
  //       await getIt.get<AccountRepo>().terminateAccount();
  //   result.fold((error) {
  //     emit(AccountTerminateFailure(errMessage: error.errMassage));
  //   }, (r) {
  //     emit(AccountTerminateSuccess());
  //   });
  // }

  Future<void> editAccount(
      {required String phone,
      required String name,
      required String email,
      required String imagePath}) async {
    emit(AccountEditLoading());
    Either<Failure, String> result = await getIt.get<AccountRepo>().editAccount(
        phone: phone, name: name, email: email, imagePath: imagePath);
    result.fold((error) {
      print(error.errMassage);
      emit(AccountEditFailure(errorMessage: error.errMassage));
    }, (edited) {
      print(edited);

      emit(AccountEditSuccess(newImagePath: edited));
    });
  }
}
