import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/enums/rating_enum.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());
  // --------------- VAR ------------------
  Rating rate = Rating.none;
  // --------------------------------------

  void chooseBookingRating(Rating rate) {
    if (this.rate != rate) {
      switch (rate) {
        case Rating.excellent:
          this.rate = Rating.excellent;
          emit(RatingExcellentState());
          break;
        case Rating.good:
          this.rate = Rating.good;
          emit(RatingGoodState());
          break;
        case Rating.bad:
          this.rate = Rating.bad;
          emit(RatingBadState());
          break;
        case Rating.none:
          break;
      }
    }
    print(rate);
  }
}
