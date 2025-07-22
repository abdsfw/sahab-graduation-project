import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/services/data/model/service_details_model/service_details_model.dart';
import 'package:sahab/feature/services/data/repo/services_repo.dart';

part 'service_details_home_state.dart';

class ServiceDetailsHomeCubit extends Cubit<ServiceDetailsHomeState> {
  ServiceDetailsHomeCubit() : super(ServiceDetailsHomeInitial());
  static ServiceDetailsHomeCubit get(context) => BlocProvider.of(context);

  Future<void> fetchServiceDetails(context, {required int ID}) async {
    emit(LoadingDetailsHomeState());
    var result = await getIt
        .get<ServicesRepo>()
        .fetchServiceDetailsByID(context, ID: ID);
    result.fold((error) {
      emit(FailureDetailsHomeState());
    }, (details) {
      emit(SuccessDetailsHomeState(details));
    });
  }
}
