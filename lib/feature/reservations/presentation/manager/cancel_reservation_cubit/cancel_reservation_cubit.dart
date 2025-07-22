import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/reservations/data/repo/reservation_repo.dart';

part 'cancel_reservation_state.dart';

class CancelReservationCubit extends Cubit<CancelReservationState> {
  CancelReservationCubit() : super(CancelReservationInitial());

  Future<void> cancelBooking({required int id}) async {
    emit(LoadingCancelReservationState());
    var data = {"status": "canceled"};
    var result = await getIt.get<ReservationRepo>().cancelBooking(
          data: data,
          id: id,
        );
    result.fold((failure) {
      emit(FailureCancelReservationState(failure.errMassage));
    }, (successResponse) {
      emit(SuccessCancelReservationState());
    });
  }
}
