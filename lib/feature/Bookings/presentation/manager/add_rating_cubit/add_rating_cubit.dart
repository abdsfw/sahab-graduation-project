import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/enums/rating_enum.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/Bookings/data/repo/booking_repo.dart';

part 'add_rating_state.dart';

class AddRatingCubit extends Cubit<AddRatingState> {
  AddRatingCubit() : super(AddRatingInitial());

  Future<void> ratingBooking(
      {required Rating rating, required int postId}) async {
    int intRating = 0;
    switch (rating) {
      case Rating.excellent:
        intRating = 100;
        break;
      case Rating.good:
        intRating = 50;
        break;
      case Rating.bad:
        intRating = 25;
        break;
      case Rating.none:
        break;
    }
    var data = {
      "rate": intRating,
      "place_id": postId,
    };
    emit(LoadingAddRatingState());
    var result = await getIt.get<BookingRepo>().postRatingServiceAndPlace(data);
    result.fold((failure) {
      emit(FailureAddRatingState(failure.errMassage));
    }, (serviceDataList) {
      // serviceData = serviceDataList;
      emit(SuccessAddRatingState());
    });
  }
}
