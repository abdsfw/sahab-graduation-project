import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/Bookings/data/model/place_booking_data_model.dart';
import 'package:sahab/feature/Bookings/data/repo/booking_repo.dart';

part 'place_booking_state.dart';

class PlaceBookingCubit extends Cubit<PlaceBookingState> {
  PlaceBookingCubit() : super(PlaceBookingInitial());
  // List<PlaceBookingDataModel> placeData = [];
  CancelToken cancelToken = CancelToken();
  Future<void> getAllBookingPlaceData(context) async {
    emit(LoadingGetPlaceDataState());
    var result = await getIt
        .get<BookingRepo>()
        .fetchBookingPlaceData(context, cancelToken: cancelToken);
    result.fold((failure) {
      emit(FailureGetPlaceDataState(failure.errMassage));
    }, (placeDataList) {
      // placeData = placeDataList;
      emit(SuccessGetPlaceDataState(placeDataList));
    });
  }

  @override
  Future<void> close() async {
    cancelToken.cancel("");
    await Future.delayed(Duration(milliseconds: 500));
    return super.close();
  }
}
