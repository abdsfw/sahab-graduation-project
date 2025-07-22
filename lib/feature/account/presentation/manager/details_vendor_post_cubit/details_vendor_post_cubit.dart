import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/data/model/place_post_details_model/place_post_details_model.dart';
import 'package:sahab/feature/account/data/model/service_model/service_model.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';

part 'details_vendor_post_state.dart';

class DetailsVendorPostCubit extends Cubit<DetailsVendorPostState> {
  DetailsVendorPostCubit() : super(DetailsVendorPostInitial());
  static DetailsVendorPostCubit get(context) => BlocProvider.of(context);

  Future<void> getDetailsPlacePost(context, {required int placeId}) async {
    emit(LoadingGetDetailsPostState());
    var result = await getIt
        .get<AccountRepo>()
        .fetchPlaceDetails(context, placeId: placeId);
    result.fold((failure) {
      emit(FailureGetDetailsPostState(failure.errMassage));
    }, (placePostDetailsModel) {
      emit(SuccessGetDetailsPostPlaceState(placePostDetailsModel));
    });
  }

  Future<void> getDetailsServicePost(context, {required int serviceId}) async {
    emit(LoadingGetDetailsPostState());
    var result = await getIt
        .get<AccountRepo>()
        .fetchServiceDetails(context, serviceId: serviceId);
    result.fold((failure) {
      emit(FailureGetDetailsPostState(failure.errMassage));
    }, (placeModel) {
      emit(SuccessGetDetailsPostServiceState(placeModel));
    });
  }
}
