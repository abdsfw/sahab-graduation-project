import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_view_state.dart';

class PageViewCubit extends Cubit<PageViewState> {
  PageViewCubit() : super(FirstPageViewState());

  void goToFirstPageView() {
    emit(FirstPageViewState());
  }

  void goToSecondPageView() {
    emit(SecondPageViewState());
  }
}
