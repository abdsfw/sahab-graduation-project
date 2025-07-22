import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/places/data/model/place_details_model.dart';
import 'package:sahab/feature/places/data/model/place_details_model/place_details_model.dart';
import 'package:sahab/feature/places/data/repo/place_repo.dart';

part 'place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  PlaceDetailsCubit() : super(PlaceDetailsInitial());
  static PlaceDetailsCubit get(context) => BlocProvider.of(context);
  PlaceDetailsModel? placeDetails;
  Future<void> fetchPlaceDetails(context, {required int placeId}) async {
    emit(PlaceDetailsLoading());
    Either<Failure, PlaceDetailsModel> result = await getIt
        .get<PlaceRepo>()
        .fetchPlacesDetails(context, placeId: placeId);
    result.fold((error) {
      emit(PlaceDetailsLoadFailure(error.errMassage));
    }, (fetchDetails) {
      debugPrint("bookable : ${fetchDetails.bookable}");
      placeDetails = fetchDetails;
      emit(PlaceDetailsLoadSuccess(fetchDetails));
    });
  }
}
