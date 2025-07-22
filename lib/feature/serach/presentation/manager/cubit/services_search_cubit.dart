import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/serach/data/repo/search_repo.dart';
import 'package:sahab/feature/services/data/model/service.dart';

part 'services_search_state.dart';

class ServicesSearchCubit extends Cubit<ServicesSearchState> {
  ServicesSearchCubit() : super(ServicesSearchInitial());
  //! var
  List<Services> servicesList = [];
  num totalPrice = 0;
  String? query;
  static ServicesSearchCubit get(context) => BlocProvider.of(context);
  //! function
  Future<void> fetchSearchServices(String searchQuery, {String? query}) async {
    emit(ServicesSearchLoading());
    var result = await getIt
        .get<SearchRepo>()
        .fetchSearchServices(searchQuery, query: query);
    result.fold((error) {
      emit(ServicesSearchFailure(errMessage: error.errMassage));
    }, (servicesFetchedList) {
      servicesList = servicesFetchedList.value1;
      totalPrice = servicesFetchedList.value2;

      emit(ServicesSearchSuccess());
    });
  }

  int resultServicesNumber() {
    return servicesList.length;
  }

  void restServiceSearch() {
    emit(ServicesSearchInitial());
  }
}
