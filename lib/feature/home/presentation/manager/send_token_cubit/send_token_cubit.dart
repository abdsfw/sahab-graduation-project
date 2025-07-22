import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/home/data/repo/home_repo.dart';

part 'send_token_state.dart';

class SendTokenCubit extends Cubit<SendTokenState> {
  SendTokenCubit() : super(SendTokenInitial());
  static SendTokenCubit get(context) => BlocProvider.of(context);
  Future<void> sendToken(String token) async {
    emit(SendTokenLoading());
    var result = await getIt.get<HomeRepo>().sendToken({"token": token});
    result.fold((error) {
      emit(SendTokenFailure(errMessage: error.errMassage));
    }, (sended) {
      emit(SendTokenSuccess());
    });
  }
}
