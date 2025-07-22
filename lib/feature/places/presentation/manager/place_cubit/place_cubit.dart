import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/places/data/model/featured_place/feature_place_model/feature_place_model.dart';
import 'package:sahab/feature/places/data/model/featured_place/featured_place.dart';
import 'package:sahab/feature/places/data/model/place_details_model.dart';
import 'package:sahab/feature/places/data/model/place_model.dart';
import 'package:sahab/feature/places/data/repo/place_repo.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit() : super(PlaceInitial());
  //! ------var------
  static PlaceCubit get(context) =>
      BlocProvider.of(context); //? to get the placeCubit
  List<PlaceModel> places = []; // ? this i use it to Ui , in place view page .

  List<PlaceModel> fetchPlaceList = []; //? this list storage the place fromApi
  List<FeaturePlaceModel> fetchedPlaced = [];
  List<FeaturePlaceModel> homeFeaturedPlaces = [];

  num maxPrice = 0;
  String? query;
  // int nextPage = 2;
  // int groupValueSort = -1; // ? to change radio Sort
  // int groupValueType = -1; // ? to change radio type
  int total = 0;
  //! ------endVar------

  //! -----Functions----

  // void changeRadioValueSort(int value) {
  //   groupValueSort = value;
  //   emit(RadioFilterState());
  // }

  // void changeRadioValueType(int value) {
  //   groupValueType = value;
  //   emit(RadioFilterState());
  // }

  // int resetPage() {
  //   nextPage = 1;
  //   groupValueSort = -1;
  //   groupValueType = -1;
  //   return nextPage;
  // }

  Future<void> fetchAllFuturePlaces(context, {String? query}) async {
    fetchedPlaced = [];
    emit(PlaceLoading());
    var result = await getIt
        .get<PlaceRepo>()
        .fetchAllFuturePlaces(context, query: query);
    result.fold((error) {
      emit(PlaceLoadFailure(error.errMassage, error.statusCode));
    }, (fetched) {
      if (query == null) {
        this.maxPrice = fetched.value2;
      }
      if (query == "limit=7") {
        this.homeFeaturedPlaces = fetched.value1;
      } else {
        fetchedPlaced = fetched.value1;
      }
      emit(PlaceLoadSuccess());
    });
  }

  // Future<void> fetchPlace({int pageNumber = 1, String? query}) async {
  //   //? this Function call Api to fetch Place
  //   if (pageNumber == 1) {
  //     emit(PlaceLoading());
  //   }

  //   Either<Failure, Tuple2<List<PlaceModel>, int>> result = await getIt
  //       .get<PlaceRepo>()
  //       .fetchHomePlaces(pageNumber: pageNumber, query: query);
  //   result.fold(
  //     (error) {
  //       if (pageNumber == 0) {
  //         emit(PlaceLoadFailure(error.errMassage));
  //       } else {
  //         emit(PlacePaginationFailure(error.errMassage));
  //       }
  //     },
  //     (fetchedList) {
  //       total = fetchedList.value2;
  //       if (fetchedList.value1.isNotEmpty) {
  //         emit(PlaceLoadMore());
  //         fetchPlaceList = fetchedList.value1;
  //         if (total == 1) {
  //           emit(PlaceLoadSuccess());
  //         }
  //       } else {
  //         if (pageNumber == 1) {
  //           // If pageNumber is 1 and fetchedList.value1 is empty,
  //           // it means there are no more places to load
  //           emit(PlaceLoadSuccess());
  //         } else {
  //           // If pageNumber is not 1 and fetchedList.value1 is empty,
  //           // it means there are no more places to load for the current page
  //           emit(PlacePaginationFailure("No more places to load."));
  //         }
  //       }
  //     },
  //   );
  // }
}
