import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/Bookings/data/model/service_booking_data_model.dart';
import 'package:sahab/feature/Bookings/data/repo/booking_repo.dart';
import 'package:sahab/feature/reservations/data/model/service_reservation_data_model.dart';
import 'package:sahab/feature/reservations/data/repo/reservation_repo.dart';

part 'service_reservation_state.dart';

class ServiceReservationCubit extends Cubit<ServiceReservationState> {
  ServiceReservationCubit() : super(ServiceReservationInitial());

  // List<ServiceBookingDataModel> serviceData = [];

  Future<void> getAllBookingServiceData(context) async {
    emit(LoadingGetReservationServiceDataState());
    var result =
        await getIt.get<ReservationRepo>().fetchReservationServiceData(context);
    result.fold((failure) {
      emit(FailureGetReservationServiceDataState(failure.errMassage));
    }, (serviceDataList) {
      // serviceData = serviceDataList;
      emit(SuccessGetReservationServiceDataState(serviceDataList));
    });
  }
}
