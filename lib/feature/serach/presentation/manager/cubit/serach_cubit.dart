import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/serach/data/model/serach_place_model.dart';
import 'package:sahab/feature/serach/data/repo/search_repo.dart';
part 'serach_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  List<SearchPlaceModel> searchList = [];
  int resultNumber = 0;
  num maxPrice = 0;
  String? query;
  static SearchCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();

  Future<void> fetchSearchPlaces(String searchQuery, {String? query}) async {
    emit(SearchLoading());
    var result = await getIt
        .get<SearchRepo>()
        .fetchSearchPlaces(searchQuery, query: query);
    result.fold((error) {
      emit(SearchFailure(errMessage: error.errMassage));
    }, (searchListFetched) {
      searchList = searchListFetched.value1;
      maxPrice = searchListFetched.value2;
      resultNumber = searchList.length;
      emit(SearchSuccess());
    });
  }

  void resetSearch() {
    emit(SearchInitial());
  }
}
