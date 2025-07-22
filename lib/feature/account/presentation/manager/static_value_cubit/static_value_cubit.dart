import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/data/model/static_vendor_value_model/static_vendor_value.dart';
import 'package:sahab/feature/account/data/model/statistics_vendor_value/static_value.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';

part 'static_value_state.dart';

class StaticValueCubit extends Cubit<StaticValueState> {
  StaticValueCubit() : super(StaticValueInitial());
  static StaticValueCubit get(context) => BlocProvider.of(context);
  StaticVendorValue staticValue = StaticVendorValue();
  Future<void> fetchStaticValue() async {
    emit(StaticValueLoading());
    var result = await getIt.get<AccountRepo>().fetchVendorStaticValue();
    result.fold((error) {
      emit(StaticValueFailure(errMessage: error.errMassage));
    }, (fetched) {
      staticValue = fetched;
      emit(StaticValueSuccess());
    });
  }
}
