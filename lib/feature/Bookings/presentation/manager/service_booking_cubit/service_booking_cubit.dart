import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/Bookings/data/model/service_booking_data_model.dart';
import 'package:sahab/feature/Bookings/data/repo/booking_repo.dart';

part 'service_booking_state.dart';

class ServiceBookingCubit extends Cubit<ServiceBookingState> {
  ServiceBookingCubit() : super(ServiceBookingInitial());

  // List<ServiceBookingDataModel> serviceData = [];

  Future<void> getAllBookingServiceData(context) async {
    emit(LoadingGetServiceDataState());
    var result =
        await getIt.get<BookingRepo>().fetchBookingServiceData(context);
    result.fold((failure) {
      emit(FailureGetServiceDataState(failure.errMassage));
    }, (serviceDataList) {
      // serviceData = serviceDataList;
      emit(SuccessGetServiceDataState(serviceDataList));
    });
  }
}
