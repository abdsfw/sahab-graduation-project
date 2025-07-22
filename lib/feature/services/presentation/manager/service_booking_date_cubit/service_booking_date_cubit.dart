import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/services/data/repo/services_repo.dart';

part 'service_booking_date_state.dart';

class ServiceBookingDateCubit extends Cubit<ServiceBookingDateState> {
  ServiceBookingDateCubit() : super(ServiceBookingDateInitial());
  static ServiceBookingDateCubit get(context) => BlocProvider.of(context);

  num? price;
  int? id;
  String? serviceTitle;
  dynamic enableServiceDate;
  void setPriceTitleId(
      {required num price, required String serviceTitle, required int id}) {
    this.price = price;
    this.id = id;
    this.serviceTitle = serviceTitle;
  }

  Future<void> fetchEnableService({required int serviceId}) async {
    emit(LoadingFetchServiceDates());
    var result =
        await getIt.get<ServicesRepo>().fetchServiceDates(serviceId: serviceId);
    result.fold((error) {
      emit(FailureFetchServiceDates());
    }, (dates) {
      this.enableServiceDate = dates;
      emit(SuccessFetchServiceDates());
    });
  }
}
