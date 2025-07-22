import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/feature/categories/presentation/manager/cubit/category_cubit.dart';
import 'package:sahab/feature/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:sahab/feature/places/presentation/manager/place_cubit/place_cubit.dart';
import 'package:sahab/feature/services/presentation/manager/service_cubit/service_cubit.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitial());

  String lang = CacheHelper.getData(key: Constant.kLang);

  String langUi =
      (CacheHelper.getData(key: Constant.kLang) == 'ar') ? 'ع' : 'en';

  void firstChooseLang({required String language}) async {
    await CacheHelper.setData(key: Constant.kLang, value: language);
    lang = language; //CacheHelper.getData(key: Constant.kLang);
    emit(FirstChooseLangScreenState());
  }

  void changeLang(context, {required String language}) {
    if (language != lang) {
      if (language == 'en') {
        CacheHelper.setData(key: Constant.kLang, value: 'en');
        lang = language;
        langUi = "en";
        emit(ChooseEnLangScreenState());
      } else {
        CacheHelper.setData(key: Constant.kLang, value: 'ar');
        lang = language;
        langUi = "ع";
        emit(ChooseArLangScreenState());
      }
      BlocProvider.of<CategoryCubit>(context).fetchCategory(context);
      BlocProvider.of<ServiceCubit>(context).fetchServices(context);
      BlocProvider.of<HomeCubit>(context).fetchUserData(context);
      BlocProvider.of<PlaceCubit>(context)
          .fetchAllFuturePlaces(context, query: "limit=7");
    }
  }
}
