import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/data/model/vendor_service_post_model/vendor_service_post_model.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';
import 'package:sahab/feature/account/presentation/manager/my_post_cubit/my_post_cubit.dart';

part 'service_post_vendor_state.dart';

class ServicePostVendorCubit extends Cubit<ServicePostVendorState> {
  ServicePostVendorCubit() : super(ServicePostVendorInitial());
  static MyPostCubit get(context) => BlocProvider.of(context);
  Future<void> getVendorServicePosts(context) async {
    emit(LoadingServicePostVendorState());
    var result = await getIt.get<AccountRepo>().fetchVendorServicePost(context);
    result.fold((failure) {
      print(failure.errMassage);
      emit(FailureServicePostVendorState(failure.errMassage));
    }, (serviceDataList) {
      // placeData = placeDataList;
      emit(SuccessServicePostVendorState(serviceDataList));
    });
  }
}
