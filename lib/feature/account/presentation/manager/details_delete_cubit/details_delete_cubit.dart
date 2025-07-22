import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';

part 'details_delete_state.dart';

class DetailsDeleteCubit extends Cubit<DetailsDeleteState> {
  DetailsDeleteCubit() : super(DetailsDeleteInitial());

  Future<void> deleteVendorPlacePost({required int placeId}) async {
    emit(LoadingDeletePostState());
    var result = await getIt.get<AccountRepo>().deletePlace(placeId: placeId);
    result.fold((failure) {
      emit(FailureDeletePostState(failure.errMassage));
    }, (successResponse) {
      emit(SuccessDeletePostState());
    });
  }

  Future<void> deleteVendorServicePost({required int serviceId}) async {
    emit(LoadingDeletePostState());
    var result =
        await getIt.get<AccountRepo>().deleteService(serviceId: serviceId);
    result.fold((failure) {
      emit(FailureDeletePostState(failure.errMassage));
    }, (successResponse) {
      emit(SuccessDeletePostState());
    });
  }
}
