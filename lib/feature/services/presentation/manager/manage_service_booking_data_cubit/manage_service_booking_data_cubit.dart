import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_service_booking_data_state.dart';

class ManageServiceBookingDataCubit
    extends Cubit<ManageServiceBookingDataState> {
  ManageServiceBookingDataCubit() : super(ManageServiceBookingDataInitial());
  static ManageServiceBookingDataCubit get(context) => BlocProvider.of(context);

  TextEditingController addressController = TextEditingController();

  DateTime? selectedDate;

  DateTimeRange? selectedRangeTime;
  List<DateTimeRange> timeOfSelectedDate = [];
  List<String> timeOfDate = [];
  void makeRangeDateTimeToRangeOfTime(List<dynamic> data) {
    timeOfDate = [];
    timeOfSelectedDate = [];
    for (var range in data) {
      DateTimeRange rangeDateTime = DateTimeRange(
          start: DateTime.parse(range[0]), end: DateTime.parse(range[1]));
      timeOfSelectedDate.add(rangeDateTime);
      int hour1 = rangeDateTime.start.hour;
      int hour2 = rangeDateTime.end.hour;
      int minute1 = rangeDateTime.start.minute;
      int minute2 = rangeDateTime.end.minute;
      String late1 = 'AM';
      String late2 = 'AM';
      if (hour1 > 12) {
        hour1 -= 12;
        late1 = 'PM';
      }
      if (hour2 > 12) {
        hour2 -= 12;
        late2 = 'PM';
      }
      String time11 = "$hour1:$minute1$late1";
      String time22 = "$hour2:$minute2$late2";

      String time1 = "";
      String time2 = "";
      if (hour1 < 10) {
        time1 += "0" + hour1.toString() + ":";
      } else {
        time1 += hour1.toString() + ":";
      }
      if (minute1 < 10) {
        time1 += "0" + minute1.toString();
      } else {
        time1 += minute1.toString();
      }
      if (hour2 < 10) {
        time2 += "0" + hour2.toString() + ":";
      } else {
        time2 += hour2.toString() + ":";
      }
      if (minute2 < 10) {
        time2 += "0" + minute2.toString();
      } else {
        time2 += minute2.toString();
      }
      time1 += late1;
      time2 += late2;
      print(time1);
      print(time2);
      timeOfDate.add(time1 + "     " + time2);
      // timeOfDate.add(time11 + "     " + time22);
    }
  }

  void searchInDate(String rangeTime) {
    int index = timeOfDate.indexWhere((element) => element == rangeTime);
    if (index != -1) {
      selectedRangeTime = timeOfSelectedDate[index];
      checkIfCanGoToCHeckout();
    }
  }

  void setSelectedDate({required DateTime? selected}) {
    this.selectedDate = selected;
    this.selectedRangeTime = null;
    emit(ManageServiceBookingDataInitial());
    checkIfCanGoToCHeckout();
  }

  void checkIfCanGoToCHeckout() {
    if (addressController.text.isNotEmpty &&
        selectedDate != null &&
        selectedRangeTime != null) {
      emit(SuccessToGoToCheckout());
    } else {
      emit(ManageServiceBookingDataInitial());
    }
  }
}
