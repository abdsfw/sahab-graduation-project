import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/categories/data/model/category_model.dart';
import 'package:sahab/feature/categories/data/repo/category_repo.dart';
import 'package:sahab/feature/services/data/model/service_model.dart';
import 'package:sahab/feature/services/data/repo/services_repo.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());
  //! ------var------
  static ServiceCubit get(context) => BlocProvider.of(context);

  List<CategoryModel> fetchServiceList = [];
  // List<CategoryModel> filteredList = [];
  int? sortBy;
  //!------EndVar------
  //!------Functions------
  Future<void> fetchServices(context) async {
    emit(ServiceLoading());
    Either<Failure, List<CategoryModel>> result = await getIt
        .get<CategoryRepo>()
        .fetchHomeCategory(Constant.kService, context);
    result.fold((error) => emit(ServiceLoadFailure(error.errMassage)),
        (fetchedList) {
      fetchServiceList = fetchedList;
      // filteredList = List.from(fetchServiceList);

      emit(ServiceLoadSuccess());
    });
  }

  // void applyFilter() {
  //   filteredList = List.from(fetchServiceList);
  //   switch (sortBy) {
  //     case 0: //? Newest
  //       filteredList.sort((a, b) => a.id.compareTo(b.id));
  //       break;
  //     case 1: //? Highest Rating
  //       filteredList.sort((a, b) => a.rating.compareTo(b.rating));
  //       break;
  //     case 2: //? High to Low
  //       filteredList.sort((a, b) => b.price.compareTo(a.price));
  //       break;
  //     case 3: //? Low to High
  //       filteredList.sort((a, b) => a.price.compareTo(b.price));
  //       break;
  //     default:
  //       break;
  //   }
  //   for (var service in filteredList) {
  //     if (kDebugMode) {
  //       print(
  //           'ID: ${service.id}, Rating: ${service.rating}, Price: ${service.price} , ${service.rating.runtimeType}');
  //     }
  //   }
  //   if (kDebugMode) {
  //     print('\n \n');
  //   }
  //   for (var service in fetchServiceList) {
  //     if (kDebugMode) {
  //       print(
  //           'ID: ${service.id}, Rating: ${service.rating}, Price: ${service.price}');
  //     }
  //   }
  //   emit(ServiceChangeFlitter(flitterType: sortBy ?? 0));
  // }
}
