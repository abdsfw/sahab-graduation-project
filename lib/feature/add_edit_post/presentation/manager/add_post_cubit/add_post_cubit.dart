import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/main_post_page_cubit/main_post_page_cubit.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/next_post_place_cubit/next_post_place_cubit.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/next_post_service_cubit/next_post_service_cubit.dart';

import 'package:sahab/feature/add_edit_post/presentation/manager/select_photo_cubit/select_photo_cubit.dart';

import '../../../data/repo/add_edit_post_repo.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());
  static AddPostCubit get(context) => BlocProvider.of(context);

  Future<void> sendAddPostPlace(context) async {
    //? loading state
    emit(LoadingAddEditPostState());
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);
    SelectPhotoCubit selectPhotoCubit = SelectPhotoCubit.get(context);
    MainPostPageCubit mainPostCubit = MainPostPageCubit.get(context);
    int? placeId;
    for (var placeCategory in mainPostCubit.categoryList) {
      if (placeCategory.title == nextPostPlaceCubit.selectCategoryDropDown) {
        placeId = placeCategory.id;
      }
    }
    int? areaId;
    for (var areaItem in mainPostCubit.areaList) {
      if (areaItem.area == nextPostPlaceCubit.selectAreaDropDown) {
        areaId = areaItem.id;
      }
    }
    List<int?> aminity = nextPostPlaceCubit.amenitySelectedList
        .map(
          (e) => e.id,
        )
        .toList();
    var bodyFormData = {
      "vendor_id": await CacheHelper.getData(key: Constant.kUserId),
      //? title here
      "title": nextPostPlaceCubit.titleController.text,
      //? select category
      "category_id": placeId ?? -1, //nextPostPlaceCubit.selectCategoryDropDown,
      //? place type
      "tag": nextPostPlaceCubit.selectPlaceTypeDropDown,
      //? amenities
      // "amenities": aminity,
      //? area
      "area_id": areaId, //nextPostPlaceCubit.selectAreaDropDown,
      //? address
      "address": nextPostPlaceCubit.addressController.text,
      //? about place
      "description": nextPostPlaceCubit.aboutPlaceController.text,
      //? upload image
      // "icon": selectPhotoCubit.imageFile
      //     .map(
      //       (e) async => await MultipartFile.fromFile(e.path, filename: e.path),
      //     )
      //     .toList(),
      //? weekday price
      "weekday_price": nextPostPlaceCubit.weekdayController.text,
      //? weekend price
      "weekend_price": nextPostPlaceCubit.weekendController.text,
      //? special Days
      // "specialDays": nextPostPlaceCubit.specialDaysList
      //     .map((e) => {
      //           "start_date": e.rangeDate.start.toIso8601String(),
      //           "end_date": e.rangeDate.end.toIso8601String(),
      //           "title": e.title,
      //           "price": e.price,
      //         })
      //     .toList(),
    };

    print(aminity);
    for (var i = 0; i < aminity.length; i++) {
      bodyFormData["amenities[${i.toString()}]"] = aminity[i];
    }
    for (var i = 0; i < selectPhotoCubit.imageFile.length; i++) {
      bodyFormData["icon[${i.toString()}]"] = await MultipartFile.fromFile(
        selectPhotoCubit.imageFile[i].path,
        filename: selectPhotoCubit.imageFile[i].path,
      );
      // "icon": selectPhotoCubit.imageFile
      //       .map(
      //         (e) async => await MultipartFile.fromFile(e.path, filename: e.path),
      //       )
      //       .toList(),
    }
    for (var i = 0; i < nextPostPlaceCubit.specialDaysList.length; i++) {
      var e = nextPostPlaceCubit.specialDaysList[i];
      bodyFormData["specialDays[${i.toString()}]"] = {
        "start_date": DateFormat("yyyy-MM-dd", "en").format(e.rangeDate.start),
        "end_date": DateFormat("yyyy-MM-dd", "en").format(e.rangeDate.end),
        "title": e.title,
        "price": e.price,
      };

      // "specialDays": nextPostPlaceCubit.specialDaysList
      //     .map((e) => {
      //           "start_date": e.rangeDate.start.toIso8601String(),
      //           "end_date": e.rangeDate.end.toIso8601String(),
      //           "title": e.title,
      //           "price": e.price,
      //         })
      //     .toList(),
    }
    var data = FormData.fromMap(bodyFormData);

    print(data.fields);
    var result =
        await getIt.get<AddEditPostRepo>().sendAddPostPlace(data: data);
    result.fold((failure) async {
      print(failure.errMassage);
      emit(FailureAddEditPostState());
    }, (successMessage) async {
      nextPostPlaceCubit.clearControllers();
      selectPhotoCubit.clearCubitData();
      emit(SuccessAddEditPostState());
    });
  }

  Future<void> sendAddPostService(context) async {
    //? loading state
    emit(LoadingAddEditPostState());
    NextPostServiceCubit nextPostServiceCubit =
        NextPostServiceCubit.get(context);
    SelectPhotoCubit selectPhotoCubit = SelectPhotoCubit.get(context);
    MainPostPageCubit mainPostCubit = MainPostPageCubit.get(context);
    int? serviceId;
    for (var serviceCategory in mainPostCubit.serviceList) {
      if (serviceCategory.title == nextPostServiceCubit.selectServiceDropDown) {
        serviceId = serviceCategory.id;
      }
    }
    var bodyFormData = {
      "vendor_id": await CacheHelper.getData(key: Constant.kUserId),
      //? title here
      "title": nextPostServiceCubit.titleController.text,
      //? select service
      "category_id":
          serviceId ?? -1, //1, //nextPostServiceCubit.selectServiceDropDown,
      //? about service
      "description": nextPostServiceCubit.aboutServiceController.text,
      //? upload images
      // "icon": selectPhotoCubit.imageFile
      //     .map(
      //       (e) async => await MultipartFile.fromFile(e.path, filename: e.path),
      //     )
      //     .toList(),
      //? service duration
      "duration": nextPostServiceCubit.durationController.text,
      //? service price
      "price": nextPostServiceCubit.priceController.text,
      //? Notice period
      "notice_period": nextPostServiceCubit.noticePeriodController.text,
      //? Capacity
      "max_capacity": nextPostServiceCubit.capacityController.text,
    };

    for (var i = 0; i < selectPhotoCubit.imageFile.length; i++) {
      bodyFormData["icon[${i.toString()}]"] = await MultipartFile.fromFile(
        selectPhotoCubit.imageFile[i].path,
        filename: selectPhotoCubit.imageFile[i].path,
      );
      // "icon": selectPhotoCubit.imageFile
      //     .map(
      //       (e) async => await MultipartFile.fromFile(e.path, filename: e.path),
      //     )
      //     .toList(),
    }

    var data = FormData.fromMap(bodyFormData);
    print(data.fields);

    var result =
        await getIt.get<AddEditPostRepo>().sendAddPostService(data: data);
    result.fold((failure) async {
      print(failure.errMassage);
      emit(FailureAddEditPostState());
    }, (successMessage) async {
      nextPostServiceCubit.clearControllers();
      selectPhotoCubit.clearCubitData();
      emit(SuccessAddEditPostState());
    });
  }

  Future<void> editPostService(context, {required int servicePostId}) async {
    //? loading state
    emit(LoadingAddEditPostState());
    NextPostServiceCubit nextPostServiceCubit =
        NextPostServiceCubit.get(context);
    SelectPhotoCubit selectPhotoCubit = SelectPhotoCubit.get(context);
    MainPostPageCubit mainPostCubit = MainPostPageCubit.get(context);
    int? serviceId;
    for (var serviceCategory in mainPostCubit.serviceList) {
      if (serviceCategory.title == nextPostServiceCubit.selectServiceDropDown) {
        serviceId = serviceCategory.id;
      }
    }
    var bodyFormData = {
      // "vendor_id": await CacheHelper.getData(key: Constant.kUserId),
      // //? title here
      "title": nextPostServiceCubit.titleController.text,
      //? select service
      "category_id":
          serviceId ?? -1, //1, //nextPostServiceCubit.selectServiceDropDown,
      //? about service
      "description": nextPostServiceCubit.aboutServiceController.text,
      //? upload images
      // "icon": selectPhotoCubit.imageFile
      //     .map(
      //       (e) async => await MultipartFile.fromFile(e.path, filename: e.path),
      //     )
      //     .toList(),
      //? service duration
      "duration": nextPostServiceCubit.durationController.text,
      //? service price
      "price": nextPostServiceCubit.priceController.text,
      //? Notice period
      "notice_period": nextPostServiceCubit.noticePeriodController.text,
      //? Capacity
      "max_capacity": nextPostServiceCubit.capacityController.text,
    };
    for (var i = 0; i < selectPhotoCubit.imageFile.length; i++) {
      bodyFormData["icon[${i.toString()}]"] = await MultipartFile.fromFile(
        selectPhotoCubit.imageFile[i].path,
        filename: selectPhotoCubit.imageFile[i].path,
      );

      // "icon": selectPhotoCubit.imageFile
      //     .map(
      //       (e) async => await MultipartFile.fromFile(e.path, filename: e.path),
      //     )
      //     .toList(),
    }
    var data = FormData.fromMap(bodyFormData);
    print(data.fields);
    var result = await getIt
        .get<AddEditPostRepo>()
        .editPostService(data: data, serviceId: servicePostId);
    result.fold((failure) async {
      print(failure.errMassage);
      emit(FailureAddEditPostState());
    }, (successMessage) async {
      nextPostServiceCubit.clearControllers();
      selectPhotoCubit.clearCubitData();
      emit(SuccessAddEditPostState());
    });
  }

  Future<void> editPostPlace(context, {required int placePostId}) async {
    //? loading state
    emit(LoadingAddEditPostState());
    NextPostPlaceCubit nextPostPlaceCubit = NextPostPlaceCubit.get(context);
    SelectPhotoCubit selectPhotoCubit = SelectPhotoCubit.get(context);
    MainPostPageCubit mainPostCubit = MainPostPageCubit.get(context);
    int? placeId;
    for (var placeCategory in mainPostCubit.categoryList) {
      if (placeCategory.title == nextPostPlaceCubit.selectCategoryDropDown) {
        placeId = placeCategory.id;
      }
    }
    int? areaId;
    for (var areaItem in mainPostCubit.areaList) {
      if (areaItem.area == nextPostPlaceCubit.selectAreaDropDown) {
        areaId = areaItem.id;
      }
    }
    List<int?> aminity = nextPostPlaceCubit.amenitySelectedList
        .map(
          (e) => e.id,
        )
        .toList();
    var bodyFormData = {
      // "vendor_id": await CacheHelper.getData(key: Constant.kUserId),
      //? title here
      "title": nextPostPlaceCubit.titleController.text,
      //? select category
      "category_id": placeId ?? -1, //nextPostPlaceCubit.selectCategoryDropDown,
      //? place type
      "tag": nextPostPlaceCubit.selectPlaceTypeDropDown,
      //? amenities
      // "amenities": nextPostPlaceCubit.amenitySelectedList
      //     .map(
      //       (e) => e.id,
      //     )
      //     .toList(),
      //? area
      "area_id": areaId, //nextPostPlaceCubit.selectAreaDropDown,
      //? address
      "address": nextPostPlaceCubit.addressController.text,
      //? about place
      "description": nextPostPlaceCubit.aboutPlaceController.text,
      //? upload image
      // "icon": selectPhotoCubit.imageFile
      //     .map(
      //       (e) async => await MultipartFile.fromFile(e.path, filename: e.path),
      //     )
      //     .toList(),
      //? weekday price
      "weekday_price": nextPostPlaceCubit.weekdayController.text,
      //? weekend price
      "weekend_price": nextPostPlaceCubit.weekendController.text,
      //? special Days
      // "specialDays": nextPostPlaceCubit.specialDaysList
      //     .map((e) => {
      //           "start_date": e.rangeDate.start.toIso8601String(),
      //           "end_date": e.rangeDate.end.toIso8601String(),
      //           "title": e.title,
      //           "price": e.price,
      //         })
      //     .toList(),
    };
    for (var i = 0; i < aminity.length; i++) {
      bodyFormData["amenities[${i.toString()}]"] = aminity[i];
    }
    for (var i = 0; i < selectPhotoCubit.imageFile.length; i++) {
      bodyFormData["icon[${i.toString()}]"] = await MultipartFile.fromFile(
        selectPhotoCubit.imageFile[i].path,
        filename: selectPhotoCubit.imageFile[i].path,
      );
      // "icon": selectPhotoCubit.imageFile
      //       .map(
      //         (e) async => await MultipartFile.fromFile(e.path, filename: e.path),
      //       )
      //       .toList(),
    }
    for (var i = 0; i < nextPostPlaceCubit.specialDaysList.length; i++) {
      var e = nextPostPlaceCubit.specialDaysList[i];
      bodyFormData["specialDays[${i.toString()}]"] = {
        "start_date": DateFormat("yyyy-MM-dd").format(e.rangeDate.start),
        "end_date": DateFormat("yyyy-MM-dd").format(e.rangeDate.end),
        "title": e.title,
        "price": e.price,
      };

      // "specialDays": nextPostPlaceCubit.specialDaysList
      //     .map((e) => {
      //           "start_date": e.rangeDate.start.toIso8601String(),
      //           "end_date": e.rangeDate.end.toIso8601String(),
      //           "title": e.title,
      //           "price": e.price,
      //         })
      //     .toList(),
    }
    var data = FormData.fromMap(bodyFormData);
    print(data.fields);
    var result = await getIt
        .get<AddEditPostRepo>()
        .editPostPlace(data: data, placeId: placePostId);
    result.fold((failure) async {
      print(failure.errMassage);
      emit(FailureAddEditPostState());
    }, (successMessage) async {
      nextPostPlaceCubit.clearControllers();
      selectPhotoCubit.clearCubitData();
      emit(SuccessAddEditPostState());
    });
  }
}
