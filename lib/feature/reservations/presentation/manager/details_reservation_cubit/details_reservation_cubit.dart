import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/enums/type_post_enum.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/reservations/data/model/place_reservation_details_model.dart';
import 'package:sahab/feature/reservations/data/model/service_reservation_details_model.dart';
import 'package:sahab/feature/reservations/data/repo/reservation_repo.dart';

part 'details_reservation_state.dart';

class DetailsReservationCubit extends Cubit<DetailsReservationState> {
  DetailsReservationCubit() : super(DetailsReservationInitial());

  Future<void> getReservationDetails(context,
      {required int id, required TypeToggle typeToggle}) async {
    if (TypeToggle.place == typeToggle) {
      emit(LoadingFetchPlaceDetails());
      var result = await getIt
          .get<ReservationRepo>()
          .fetchReservationPlaceDetails(context, id: id);
      result.fold((failure) {
        emit(FailureFetchPlaceDetails(failure.errMassage));
      }, (placeDetail) {
        emit(SuccessFetchPlaceDetails(placeDetail));
      });
    } else {
      emit(LoadingFetchServiceDetails());
      var result = await getIt
          .get<ReservationRepo>()
          .fetchReservationServiceDetails(context, id: id);
      result.fold((failure) {
        emit(FailureFetchServiceDetails(failure.errMassage));
      }, (serviceDetail) {
        emit(SuccessFetchServiceDetails(serviceDetail));
      });
    }
  }
}
