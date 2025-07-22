import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/feature/add_edit_post/data/model/area_model.dart';
import 'package:sahab/feature/home/presentation/manager/area_cubit/area_cubit.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());
  static FilterCubit get(context) => BlocProvider.of(context);

  int groupValueSort = -1; // ? to change radio Sort
  int groupValueType = -1; // ? to change radio type
  int groupValueCategory = -1; // ? to change radio type
  String? idOfSelectedCategory;
  int? minPrice;
  int? maxPrice;
  void changeRadioValueSort(int value) {
    groupValueSort = value;
    emit(FilterInitial());
  }

  void changeRadioValueType(int value) {
    groupValueType = value;
    emit(FilterInitial());
  }

  void changeRadioValueCategory(int value, int? idOfSelected) {
    groupValueCategory = value;
    idOfSelectedCategory = idOfSelected.toString();
    emit(FilterInitial());
  }

  String? filterCloseTrigger(context) {
    List<String> filter = [];
    switch (groupValueSort) {
      case 0:
        filter.add("filter=newest");
        break;
      case 1:
        filter.add("filter=highest_rating");
        break;
      case 2:
        filter.add("filter=price_high_to_low");
        break;
      case 3:
        filter.add("filter=price_low_to_high");
        break;
      default:
    }
    switch (groupValueType) {
      case 0:
        filter.add("tag=All");
        break;
      case 1:
        filter.add("tag=Girls Only");
        break;
      case 2:
        filter.add("tag=Family Only");
        break;
      default:
    }
    if (groupValueCategory != -1) {
      filter.add("category=$idOfSelectedCategory");
    }
    if (maxPrice != null) {
      print(maxPrice);
      filter.add("max_price=${maxPrice.toString()}");
    }
    if (minPrice != null) {
      print(minPrice);
      filter.add("min_price=${minPrice.toString()}");
    }
    String areaString = "";
    List<AreaModel> area = BlocProvider.of<AreaCubit>(context)
        .areaList
        .where((e) => e.selected!)
        .toList();
    for (var i = 0; i < area.length; i++) {
      if (i == 0) {
        areaString += "area=${area[i].area}";
      } else {
        areaString += ",${area[i].area}";
      }
    }
    if (areaString != "") {
      filter.add(areaString);
    }
    BlocProvider.of<AreaCubit>(context).areaList = [];
    if (filter.isEmpty) {
      return null;
    } else {
      String query = '';

      for (var i = 0; i < filter.length; i++) {
        if (i == filter.length - 1) {
          query += filter[i];
        } else {
          query += "${filter[i]}&";
        }
      }

      print(query);
      return query;
      // fetchPlace(pageNumber: resetPage(), query: query);
    }
  }
}
