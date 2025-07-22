import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/data/model/vendor_place_post_model/vendor_place_post_model.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';

part 'place_post_vendor_state.dart';

class PlacePostVendorCubit extends Cubit<PlacePostVendorState> {
  PlacePostVendorCubit() : super(PlacePostVendorInitial());
  static PlacePostVendorCubit get(context) => BlocProvider.of(context);
  Future<void> getVendorPlacePosts(context) async {
    emit(LoadingPlacePostVendorState());
    var result = await getIt.get<AccountRepo>().fetchVendorPlacePost(context);
    result.fold((failure) {
      print(failure.errMassage);
      emit(FailurePlacePostVendorState(failure.errMassage));
    }, (placeDataList) {
      // placeData = placeDataList;
      emit(SuccessPlacePostVendorState(placeDataList));
    });
  }
}
