import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/services/data/model/service.dart';
import 'package:sahab/feature/services/data/repo/services_repo.dart';

part 'services_category_state.dart';

class ServicesCategoryCubit extends Cubit<ServicesCategoryState> {
  ServicesCategoryCubit() : super(ServicesCategoryInitial());
  ServicesCategoryCubit get(context) => BlocProvider.of(context);
  List<Services> fetchServicesList = [];
  num total = 0;
  num maxPrice = 0;
  String? query;
  // int count = 0;
  Future<void> fetchServicesForOneCategory(
      {int pageNumber = 1, required int categoryId, String? query}) async {
    if (pageNumber == 1) {
      emit(ServicesCategoryLoading());
    }
    Either<Failure, Tuple2<List<Services>, Map<String, num>>> result =
        await getIt.get<ServicesRepo>().fetchServicesForOneCategory(
            pageNumber: pageNumber, categoryId: categoryId, query: query);
    result.fold(
      (error) {
        if (pageNumber == 0) {
          emit(ServicesCategoryLoadFailure(error.errMassage));
        } else {
          emit(ServicesCategoryPaginationFailure(
              error.errMassage, error.statusCode));
        }
      },
      (fetchedList) {
        total = fetchedList.value2["total"] ?? 0;
        if (query == null) {
          maxPrice = fetchedList.value2["max_price"] ?? 0;
        }
        if (fetchedList.value1.isNotEmpty) {
          emit(const ServicesCategoryLoadMore());
          fetchServicesList = fetchedList.value1;
          if (total == 1) {
            emit(ServicesCategoryLoadSuccess());
          }
        } else {
          if (total == 1) {
            emit(ServicesCategoryLoadSuccess());
          } else {
            emit(ServicesCategoryLoadSuccess());
          }
        }
      },
    );
  }
}
