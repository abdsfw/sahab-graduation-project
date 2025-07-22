import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';

part 'static_page_state.dart';

class StaticPageCubit extends Cubit<StaticPageState> {
  StaticPageCubit() : super(StaticPageInitial());
  static StaticPageCubit get(context) => BlocProvider.of(context);
  String contentPage = "";
  String whatAppLink = "";
  String facebookLink = "";
  String instagramLink = "";
  String xLink = "";

  Future<void> getStaticPage(String title) async {
    emit(StaticPageLoading());
    var result = await getIt.get<AccountRepo>().fetchStaticPage(title);
    result.fold((error) {
      emit(StaticPageFailure(errMessage: error.errMassage));
    }, (content) {
      contentPage = content;
      print(content);
      emit(StaticPageSuccess());
    });
  }

  Future<void> getAllStaticLink() async {
    emit(StaticPageLoading());
    var result = await getIt.get<AccountRepo>().fetchAllStaticPage();
    result.fold((error) {
      emit(StaticPageFailure(errMessage: error.errMassage));
    }, (content) {
      for (var element in content) {
        if (element.title == "whatsapp") {
          whatAppLink = element.content ?? "";
        } else if (element.title == "facebook") {
          facebookLink = element.content ?? "";
        } else if (element.title == "instagram") {
          instagramLink = element.content ?? "";
        } else if (element.title == "X") {
          xLink = element.content ?? "";
        }
      }
      emit(StaticPageSuccess());
    });
  }

  Future<void> getWhatsAppLink() async {
    emit(StaticPageLoading());
    var result = await getIt.get<AccountRepo>().fetchStaticPage("whatsapp");
    result.fold((error) {
      emit(StaticPageFailure(errMessage: error.errMassage));
    }, (content) {
      whatAppLink = content;
      print(content);
      emit(StaticPageSuccess());
    });
  }

  Future<void> getFacebookLink() async {
    emit(StaticPageLoading());
    var result = await getIt.get<AccountRepo>().fetchStaticPage("facebook");
    result.fold((error) {
      emit(StaticPageFailure(errMessage: error.errMassage));
    }, (content) {
      facebookLink = content;
      print(content);
      emit(StaticPageSuccess());
    });
  }

  Future<void> getInstagramLink() async {
    emit(StaticPageLoading());
    var result = await getIt.get<AccountRepo>().fetchStaticPage("instagram");
    result.fold((error) {
      emit(StaticPageFailure(errMessage: error.errMassage));
    }, (content) {
      instagramLink = content;
      print(content);
      emit(StaticPageSuccess());
    });
  }

  Future<void> getXLink() async {
    emit(StaticPageLoading());
    var result = await getIt.get<AccountRepo>().fetchStaticPage("X");
    result.fold((error) {
      emit(StaticPageFailure(errMessage: error.errMassage));
    }, (content) {
      xLink = content;
      print(content);
      emit(StaticPageSuccess());
    });
  }
}
