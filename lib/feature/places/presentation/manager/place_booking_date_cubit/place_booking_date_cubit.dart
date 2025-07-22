import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sahab/core/utils/extension/date_time_extension.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/places/data/model/place_details_model/special_days.dart';
import 'package:sahab/feature/places/data/repo/place_repo.dart';

part 'place_booking_date_state.dart';

class PlaceBookingDateCubit extends Cubit<PlaceBookingDateState> {
  PlaceBookingDateCubit() : super(PlaceBookingInitial());
  static PlaceBookingDateCubit get(context) => BlocProvider.of(context);

  num weekDayPrice = 0;
  num weekEndPrice = 0;
  DateTime? startDate;
  DateTime? endDate;
  String? startDateString;
  String? endDateString;
  List<DateTime> ignoreDates = [];
  List<Tuple2<DateTime, num>> specialDays = [];
  num totalPrice = 0;

  void setSpecial(List<SpecialDays>? data) {
    if (data != null) {
      for (var element in data) {
        DateTime start = element.startDate ?? DateTime.now();
        // print("start:$start");
        // print(element.endDate);
        // print(start
        //     .add(Duration(days: 2))
        //     .isLessThatOrEqual(element.endDate ?? DateTime.now()));
        while (start.isLessThatOrEqual(element.endDate ?? DateTime.now())) {
          specialDays.add(Tuple2(start, element.price ?? 0));
          start = start.add(Duration(days: 1));
        }
      }
    }
    print(specialDays.length);
  }

  void setTwoPrice({required num weekDayPrice, required num weekEndPrice}) {
    this.weekDayPrice = weekDayPrice;
    this.weekEndPrice = weekEndPrice;
  }

  void selectStartEndDate(
      {required DateTime startDate, required DateTime endDate}) {
    this.startDate = startDate;
    this.endDate = endDate;
    this.startDateString = DateFormat("dd/MM/yyyy").format(startDate);
    this.endDateString = DateFormat("dd/MM/yyyy").format(endDate);
    print(DateFormat.EEEE().format(startDate));
    print(DateFormat.EEEE().format(endDate));
    calculateTotalPrice();
    emit(SelectedDatesPlaceBookingState());
  }

  void calculateTotalPrice() {
    num totalPrice = 0;

    DateTime start = this.startDate!;

    while (start.isLessThatOrEqual(this.endDate!)) {
      bool isSpecialDay = false;
      for (var element in specialDays) {
        if (start.isEquals(element.value1)) {
          totalPrice += element.value2;
          isSpecialDay = true;
          break;
        }
      }
      if (!isSpecialDay) {
        String nameOfDay = DateFormat.EEEE().format(start);
        if (nameOfDay == "Thursday" ||
            nameOfDay == "Friday" ||
            nameOfDay == "Saturday") {
          totalPrice += weekEndPrice;
        } else {
          totalPrice += weekDayPrice;
        }
      }
      start = start.add(Duration(days: 1));
    }

    // if (start == "Thursday" || start == "Friday") {
    //   totalPrice += weekEndPrice;
    // } else {
    //   totalPrice += weekDayPrice;
    // }

    this.totalPrice = totalPrice;
    print(this.totalPrice);
  }

  Future<void> fetchIgnorePlaceDate({required int placeId}) async {
    emit(LoadingFetchIgnoreDatesState());
    var result =
        await getIt.get<PlaceRepo>().fetchIgnoreDates(placeId: placeId);
    result.fold((error) {
      emit(FailureFetchIgnoreDatesState(error.errMassage));
    }, (ignoreDAtes) {
      this.ignoreDates = ignoreDAtes;
      print(ignoreDAtes);
      emit(SuccessFetchIgnoreDatesState());
    });
  }
}
