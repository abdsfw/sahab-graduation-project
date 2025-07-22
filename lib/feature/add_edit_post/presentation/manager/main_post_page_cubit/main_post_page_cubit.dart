import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/enums/type_post_enum.dart';
import 'package:sahab/core/utils/functions/function.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';
import 'package:sahab/feature/add_edit_post/data/model/amenity_model.dart';
import 'package:sahab/feature/add_edit_post/data/model/special_days_model.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/next_post_service_cubit/next_post_service_cubit.dart';
import 'package:sahab/feature/boarding/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:sahab/feature/categories/presentation/manager/cubit/category_cubit.dart';
import 'package:sahab/feature/services/presentation/manager/service_cubit/service_cubit.dart';
import 'package:sahab/generated/l10n.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../../categories/data/model/category_model.dart';
import '../../../data/model/area_model.dart';
import '../../../data/repo/add_edit_post_repo.dart';

part 'main_post_page_state.dart';

class MainPostPageCubit extends Cubit<MainPostPageState> {
  MainPostPageCubit() : super(MainPostPageInitial());
  static MainPostPageCubit get(context) => BlocProvider.of(context);
  //? ---- dropDown Lists ----------
  List<CategoryModel> categoryList = [];
  List<CategoryModel> serviceList = [];

  List<String> placeTypeReturn(context) {
    List<String> placeType = [
      AppFunction.typeTranslate(Constant.kFamilyOnlyPlaceType, context),
      AppFunction.typeTranslate(Constant.kGirlsOnlyPlaceType, context),
      AppFunction.typeTranslate(Constant.kAllPlaceType, context),
    ];
    return placeType;
  }

  List<AreaModel> areaList = [];
  //? ---------------------------
  Future<String> getAllArea(context) async {
    // emit(GetAllAreaLoadingState());
    areaList = [];
    var result = await getIt.get<AddEditPostRepo>().fetchAllArea(context);
    result.fold((failure) {
      print(failure.errMassage);

      // emit(GetAllAreaFailureState(failure.errMassage));
      // return failure.errMassage;
    }, (areaList) {
      this.areaList = areaList;
      // print(areaList.first.area);
      print("dsfsdfsdf");
      // emit(GetAllAreaSuccessState());
      // return "success";
    });
    // print(areaList.length);
    if (areaList.isEmpty) {
      return "error2";
    } else {
      return "success";
    }
  }

  Future<void> fetchAllDropDownListsData(
    context, {
    required bool isEdit,
    int? postId,
    required TypeToggle typeToggle,
  }) async {
    emit(GetAllDropDownListLoadingState());
    if (BlocProvider.of<CategoryCubit>(context).fetchCategoryList.isEmpty) {
      await BlocProvider.of<CategoryCubit>(context).fetchCategory(context);
    }
    if (BlocProvider.of<ServiceCubit>(context).fetchServiceList.isEmpty) {
      await BlocProvider.of<ServiceCubit>(context).fetchServices(context);
    }
    bool checkDetails = true;
    if (isEdit) {
      checkDetails = await getDetailsPost(
        context,
        postId: postId!,
        typeToggle: typeToggle,
      );
      print("check $checkDetails");
    }
    categoryList = BlocProvider.of<CategoryCubit>(context).fetchCategoryList;
    serviceList = BlocProvider.of<ServiceCubit>(context).fetchServiceList;
    String? result = await getAllArea(context);
    print(result);
    if (result == "success" &&
        categoryList.isNotEmpty &&
        serviceList.isNotEmpty &&
        checkDetails) {
      emit(GetAllDropDownListSuccessState());
    } else {
      emit(const GetAllDropDownListFailureState("error"));
    }
  }

  Future<bool> getDetailsPost(context,
      {required int postId, required TypeToggle typeToggle}) async {
    // emit(LoadingGetDetailsPostState());
    bool returnType = false;
    if (typeToggle == TypeToggle.place) {
      var result = await getIt
          .get<AccountRepo>()
          .fetchPlaceDetails(context, placeId: postId);
      await result.fold((failure) {
        print(failure.errMassage);
        returnType = false;
        // emit(FailureGetDetailsPostState(failure.errMassage));
      }, (placePostDetailsModel) {
        var nextStepCubit = NextPostPlaceCubit.get(context);
        try {
          nextStepCubit.titleController.text =
              placePostDetailsModel.title ?? "";
          // nextStepCubit.selectCategoryDropDown = placePostDetailsModel. ?? "";
          debugPrint('tag ==== ${placePostDetailsModel.tag}');
          String s = "";
          if (placePostDetailsModel.tag == "All") {
            s = S.of(context).all;
          } else if (placePostDetailsModel.tag == "Girls Only") {
            s = S.of(context).girls_only;
          } else if (placePostDetailsModel.tag == "Family Only") {
            s = S.of(context).family_only;
          }

          // print(s);

          nextStepCubit.amenitySelectedList = placePostDetailsModel.amenities
                  ?.map((e) => AmenityModel(
                        icon: e.icon,
                        id: e.id,
                        selected: true,
                        title: e.title,
                      ))
                  .toList() ??
              [];
          nextStepCubit.selectAreaDropDown = placePostDetailsModel.area;
          nextStepCubit.addressController.text =
              placePostDetailsModel.address ?? "";
          nextStepCubit.aboutPlaceController.text =
              placePostDetailsModel.description ?? "";
          nextStepCubit.weekdayController.text =
              placePostDetailsModel.weekdayPrice.toString();
          nextStepCubit.weekendController.text =
              placePostDetailsModel.weekendPrice.toString();
          nextStepCubit.specialDaysList = placePostDetailsModel.specialDays!
              .map((e) => SpecialDaysModel(
                    price: e.price.toString(),
                    rangeDate: DateTimeRange(
                        start: DateTime.parse(e.startDate!),
                        end: DateTime.parse(e.endDate!)),
                    title: e.title!,
                  ))
              .toList();

          nextStepCubit.selectPlaceTypeDropDown = s;
          nextStepCubit.selectCategoryDropDown =
              BlocProvider.of<LangCubit>(context).lang == "en"
                  ? placePostDetailsModel.category?.title ?? ""
                  : placePostDetailsModel.category?.titleAr ?? "";
          returnType = true;
        } catch (e) {
          debugPrint('exception $e');
          returnType = true;
        }
        // emit(SuccessGetDetailsPostPlaceState(placePostDetailsModel));
      });
    } else {
      var result = await getIt
          .get<AccountRepo>()
          .fetchServiceDetails(context, serviceId: postId);
      await result.fold((failure) {
        print(failure.errMassage);

        returnType = false;
        // emit(FailureGetDetailsPostState(failure.errMassage));
      }, (placeModel) {
        var nextStepCubit = NextPostServiceCubit.get(context);
        try {
          nextStepCubit.titleController.text = placeModel.title ?? "";
          nextStepCubit.aboutServiceController.text =
              placeModel.description ?? "";
          nextStepCubit.durationController.text =
              placeModel.duration.toString();
          nextStepCubit.priceController.text = placeModel.price.toString();
          nextStepCubit.capacityController.text =
              placeModel.maxCapacity.toString();
          nextStepCubit.noticePeriodController.text =
              placeModel.noticePeriod ?? "";
          nextStepCubit.selectServiceDropDown =
              BlocProvider.of<LangCubit>(context).lang == "en"
                  ? placeModel.category?.title
                  : placeModel.category?.titleAr;

          // nextStepCubit.noticePeriodController = placeModel.
          returnType = true;
        } catch (e) {
          returnType = true;
        }
        // emit(SuccessGetDetailsPostServiceState(placeModel));
      });
    }
    return returnType;
  }
}
