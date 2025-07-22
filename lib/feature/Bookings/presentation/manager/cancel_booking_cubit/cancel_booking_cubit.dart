import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/reservations/data/repo/reservation_repo.dart';

part 'cancel_booking_state.dart';

class CancelBookingCubit extends Cubit<CancelBookingState> {
  CancelBookingCubit() : super(CancelBookingInitial());

  Future<void> cancelBooking({required int id}) async {
    emit(LoadingCancelBookingState());
    var data = {"status": "canceled"};
    var result = await getIt.get<ReservationRepo>().cancelBooking(
          data: data,
          id: id,
        );
    result.fold((failure) {
      emit(FailureCancelBookingState(failure.errMassage));
    }, (successResponse) {
      emit(SuccessCancelBookingState());
    });
  }
}
