import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';

part 'terminal_account_state.dart';

class TerminalAccountCubit extends Cubit<TerminalAccountState> {
  TerminalAccountCubit() : super(TerminalAccountInitial());
  Future<void> terminateAccount() async {
    emit(TerminalAccountLoading());
    Either<Failure, String> result =
        await getIt.get<AccountRepo>().terminateAccount();
    result.fold((error) {
      emit(TerminalAccountFailure(errMessage: error.errMassage));
    }, (r) {
      emit(TerminalAccountSuccess());
    });
  }
}
