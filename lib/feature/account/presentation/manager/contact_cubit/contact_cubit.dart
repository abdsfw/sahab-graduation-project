import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';
import 'package:url_launcher/url_launcher.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());
  static ContactCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  GlobalKey<FormState> contactForm = GlobalKey<FormState>();
  Future<void> sendMessage() async {
    if (!contactForm.currentState!.validate()) {
      return;
    }
    emit(ContactLoading());
    var result = await getIt.get<AccountRepo>().sendMessage({
      "name": nameController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "message": messageController.text
    });
    result.fold((error) {
      emit(ContactFailure(errMessage: error.errMassage));
    }, (susses) {
      emit(ContactSuccess());
    });
  }

  Future<void> launchInWebView(String url) async {
    !await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  void disposeControllers() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    messageController.clear();

    emit(ContactInitial());
  }

  void initTextController() async {
    nameController.text =
        await CacheHelper.getData(key: Constant.kUserName) ?? "";
    phoneController.text =
        await CacheHelper.getData(key: Constant.kUserPhoneNumber) ?? "";
    emailController.text =
        await CacheHelper.getData(key: Constant.kUserEmail) ?? "";
  }
}
