import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/add_edit_post/data/model/amenity_model.dart';
import 'package:sahab/feature/add_edit_post/data/model/special_days_model.dart';
import 'package:sahab/feature/add_edit_post/data/repo/add_edit_post_repo.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/select_photo_cubit/select_photo_cubit.dart';
import 'package:sahab/feature/add_edit_post/presentation/manager/special_days_view_cubit/special_days_view_cubit.dart';
part 'next_post_place_state.dart';

class NextPostPlaceCubit extends Cubit<NextPostPlaceState> {
  NextPostPlaceCubit() : super(StepOnePostInitial());
  static NextPostPlaceCubit get(context) => BlocProvider.of(context);

  //! not for use now because we used controllers for checking
  // GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //! --------------------------------------------------------
  //? ------ controllers of first pageView -----------------------
  TextEditingController titleController = TextEditingController();
  String? selectCategoryDropDown;
  String? selectPlaceTypeDropDown;
  String? selectAreaDropDown;
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutPlaceController = TextEditingController();
  TextEditingController titleSpecialDateController = TextEditingController();
  TextEditingController priceSpecialDateController = TextEditingController();
  DateTimeRange? specialDateChosen;
  List<SpecialDaysModel> specialDaysList = [];
  List<AmenityModel> amenityList = [];
  List<AmenityModel> amenitySelectedList = [];
  List<String> typeArList = ["الكل", "للبنات فقط", "للعائلات فقط"];
  List<String> typeEnList = ["All", "Girls only", "Family only"];
//? ---------------------------------------------------------------

//? ------------ controllers of second pageView -----------------
  TextEditingController weekdayController = TextEditingController();
  TextEditingController weekendController = TextEditingController();
//? ---------------------------------------------------------------
  final PageController placePageController = PageController();

  bool toggleAddSelectState = false;
  bool toggleRemoveSelectState = false;

  void checkIfCanMove(context) {
    print('check if can move');
    // if (formKey.currentState!.validate()) {
    //   emit(CanMovePostState());
    // } else {
    //   emit(CanNotMovePostState());
    // }
    // !  count of controllers that have a value
    // int count = 0;

    if (titleController.text.isEmpty) {
      emit(CanNotMovePostState());
      return;
    }
    if (selectCategoryDropDown == null) {
      emit(CanNotMovePostState());
      return;
    }
    if (selectPlaceTypeDropDown == null) {
      emit(CanNotMovePostState());
      return;
    }
    if (selectAreaDropDown == null) {
      emit(CanNotMovePostState());
      return;
    }
    if (addressController.text.isEmpty) {
      emit(CanNotMovePostState());
      return;
    }
    if (aboutPlaceController.text.isEmpty) {
      emit(CanNotMovePostState());
      return;
    }
    if (amenitySelectedList.isEmpty) {
      emit(CanNotMovePostState());
      return;
    }
    if (BlocProvider.of<SelectPhotoCubit>(context).imageFile.isEmpty) {
      emit(CanNotMovePostState());
      return;
    }
    emit(CanMovePostState());
  }

  void checkIfCanPost() {
    if (weekdayController.text.isEmpty) {
      emit(StepTowPostState());
      return;
    }
    if (weekendController.text.isEmpty) {
      emit(StepTowPostState());
      return;
    }
    emit(CanPostState());
  }

  Future<void> getAllAmenity(context) async {
    emit(GetAmenityLoadingState());
    var result = await getIt
        .get<AddEditPostRepo>()
        .fetchAllAmenity(context); //homeRepo.getAllAdvertisements();
    result.fold((failure) async {
      print(failure.errMassage);
      emit(GetAmenityFailureState(failure.errMassage));
    }, (amenityList) async {
      this.amenityList = [];
      this.amenityList = amenityList;
      if (amenitySelectedList.isNotEmpty) {
        for (var element in amenityList) {
          for (var element2 in amenitySelectedList) {
            if (element2.id == element.id) {
              element.selected = element2.selected;
              break;
            }
          }
        }
      }
      emit(GetAmenitySuccessState());
    });
  }

//! here we should make emit state with toggle attribute or using another cubit
  void selectAmenity({required int index, required bool booleanValue}) {
    amenityList[index].selected = booleanValue;
    if (booleanValue) {
      amenitySelectedList.add(amenityList[index]);
      if (toggleAddSelectState) {
        emit(SelectAmenityState1());
        toggleAddSelectState = false;
      } else {
        emit(SelectAmenityState2());
        toggleAddSelectState = true;
      }
    } else {
      amenitySelectedList.removeWhere(
        (element) => element.id == amenityList[index].id,
      );
      if (toggleRemoveSelectState) {
        emit(RemoveAmenityState1());
        toggleRemoveSelectState = false;
      } else {
        emit(RemoveAmenityState2());
        toggleRemoveSelectState = true;
      }
    }
    print("********************************");
    print(amenitySelectedList.length);
    print("********************************");
  }

  void navigateToNextPageView() {
    placePageController.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
    emit(StepTowPostState());
    checkIfCanPost();
  }

  void navigateToPreviousPageView() {
    placePageController.previousPage(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        emit(CanMovePostState());
      },
    );
  }

  void clearControllers() {
    selectCategoryDropDown = null;
    selectPlaceTypeDropDown = null;
    selectAreaDropDown = null;
    titleController.clear();
    addressController.clear();
    aboutPlaceController.clear();
    amenitySelectedList.clear();
    amenityList.clear();
    weekdayController.clear();
    weekendController.clear();
    specialDateChosen = null;
    specialDaysList.clear();
    emit(StepOnePostInitial());
  }

  void addToSpecialDaysList() {
    specialDaysList.add(
      SpecialDaysModel(
        price: priceSpecialDateController.text,
        rangeDate: specialDateChosen!,
        title: titleSpecialDateController.text,
      ),
    );
  }

  void clearSpecialDaysControllers() {
    specialDateChosen = null;
    titleSpecialDateController.clear();
    priceSpecialDateController.clear();
  }

  void deleteSpecialDayByIndex(
    context, {
    required int index,
  }) {
    specialDaysList.removeAt(index);
    //? to update the state of ListView
    BlocProvider.of<SpecialDaysViewCubit>(context).updateListViewState(context);
  }
}
