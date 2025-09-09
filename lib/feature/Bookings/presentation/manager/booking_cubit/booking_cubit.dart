import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/enums/type_post_enum.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/Bookings/data/model/booking_details_place_model/booking_details_place_model.dart';
import 'package:sahab/feature/Bookings/data/model/booking_details_service_model/booking_details_service_model.dart';
import 'package:sahab/feature/Bookings/data/repo/booking_repo.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());
  static BookingCubit get(context) => BlocProvider.of(context);
  PageController pageController = PageController();
  BookingDetailsPlaceModel? bookingPlaceDetailsData;
  BookingDetailsServiceModel? bookingServiceDetailsData;
  Future<void> getBookingDetails(context,
      {required int id, required TypeToggle typeToggle}) async {
    emit(LoadingFetchDetailsBookingState());
    if (typeToggle == TypeToggle.place) {
      var result = await getIt
          .get<BookingRepo>()
          .fetchBookingPlaceDetails(context, id: id);
      result.fold((failure) {
        emit(FailureFetchDetailsBookingState(failure.errMassage));
      }, (bookingDetails) {
        this.bookingPlaceDetailsData = bookingDetails;
        debugPrint('bookingDetails: ${bookingDetails.toJson()}');
        emit(SuccessFetchDetailsBookingState());
      });
    } else {
      var result = await getIt
          .get<BookingRepo>()
          .fetchBookingServiceDetails(context, id: id);
      result.fold((failure) {
        emit(FailureFetchDetailsBookingState(failure.errMassage));
      }, (bookingDetails) {
        this.bookingServiceDetailsData = bookingDetails;
        emit(SuccessFetchDetailsBookingState());
      });
    }
  }
}
