import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/feature/Bookings/presentation/views/booking_home_page.dart';
import 'package:sahab/feature/account/presentation/view/pages/user_account_view.dart';
import '../../../../account/presentation/view/pages/vendor_account_view.dart';
import '../../pages/home_page_view.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());
  static BottomNavBarCubit get(context) => BlocProvider.of(context);

  // --------------------- VAR -------------------------
  int currentIndex = 0;
  List<Widget> pages = const [
    HomePageBody(),
    BookingMainPage(), //BookingHomePage(),
    UserAccountView(),
    // UserAccountBody(),
    // VendorAccountView(),
  ];
  // ---------------------------------------------------
  void changeCurrentIndex({required int index}) {
    if (currentIndex != index) {
      currentIndex = index;
      switch (index) {
        case 0:
          emit(HomeBottomNavBarState());
          break;
        case 1:
          emit(BookingBottomNavBarState());
          break;
        case 2:
          emit(AccountBottomNavBarState());
          break;
      }
    }
  }
}
