import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/Bookings/data/model/place_booking_data_model.dart';
import 'package:sahab/feature/Bookings/data/repo/booking_repo.dart';
import 'package:sahab/feature/reservations/data/model/place_reservation_data_model.dart';
import 'package:sahab/feature/reservations/data/repo/reservation_repo.dart';

part 'place_reservation_state.dart';

class PlaceReservationCubit extends Cubit<PlaceReservationState> {
  PlaceReservationCubit() : super(PlaceReservationInitial());
  // List<PlaceBookingDataModel> placeData = [];

  Future<void> getAllBookingPlaceData(context) async {
    emit(LoadingGetReservationPlaceDataState());
    var result =
        await getIt.get<ReservationRepo>().fetchReservationPlaceData(context);
    result.fold((failure) {
      print(failure.errMassage);
      emit(FailureGetReservationPlaceDataState(failure.errMassage));
    }, (placeDataList) {
      // placeData = placeDataList;
      emit(SuccessGetReservationPlaceDataState(placeDataList));
    });
  }
}
