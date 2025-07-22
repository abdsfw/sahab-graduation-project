import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';
import 'package:sahab/feature/add_edit_post/data/repo/add_edit_post_repo.dart';

import '../../../../../core/utils/service_locator.dart';

part 'my_post_state.dart';

class MyPostCubit extends Cubit<MyPostState> {
  MyPostCubit() : super(MyPostInitial());
  static MyPostCubit get(context) => BlocProvider.of(context);

  bool? postActive;
  bool? bookingActive;

  Future<void> deleteVendorPlacePost({required int placeId}) async {
    emit(ManageAndDeleteLoadingState());
    var result = await getIt.get<AccountRepo>().deletePlace(placeId: placeId);
    result.fold((failure) {
      emit(ManageAndDeleteFailureState(failure.errMassage));
    }, (successResponse) {
      emit(ManageAndDeletePlaceSuccessState());
    });
  }

  Future<void> manageVendorPlacePost(
      {required int placeId, required Map<String, dynamic> data}) async {
    emit(ManageAndDeleteLoadingState());
    FormData formData = FormData.fromMap(data);
    var result = await getIt
        .get<AddEditPostRepo>()
        .editPostPlace(data: formData, placeId: placeId);
    result.fold((failure) {
      emit(ManageAndDeleteFailureState(failure.errMassage));
    }, (successResponse) {
      emit(ManageAndDeletePlaceSuccessState());
    });
  }

  Future<void> deleteVendorServicePost({required int serviceId}) async {
    emit(ManageAndDeleteLoadingState());
    var result =
        await getIt.get<AccountRepo>().deleteService(serviceId: serviceId);
    result.fold((failure) {
      emit(ManageAndDeleteFailureState(failure.errMassage));
    }, (successResponse) {
      emit(ManageAndDeleteServiceSuccessState());
    });
  }

  Future<void> manageVendorServicePost(
      {required int serviceId, required Map<String, dynamic> data}) async {
    emit(ManageAndDeleteLoadingState());
    FormData formData = FormData.fromMap(data);
    var result = await getIt
        .get<AddEditPostRepo>()
        .editPostService(data: formData, serviceId: serviceId);
    result.fold((failure) {
      emit(ManageAndDeleteFailureState(failure.errMassage));
    }, (successResponse) {
      emit(ManageAndDeleteServiceSuccessState());
    });
  }
}
