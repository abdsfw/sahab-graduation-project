import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/add_edit_post/data/model/area_model.dart';
import 'package:sahab/feature/add_edit_post/data/repo/add_edit_post_repo.dart';

part 'area_state.dart';

class AreaCubit extends Cubit<AreaState> {
  AreaCubit() : super(AreaInitial());

  static AreaCubit get(context) => BlocProvider.of(context);
  List<AreaModel> areaList = [];
  bool selectAll = false;
  Future<void> getAllArea(context) async {
    emit(GetAllAreaLoadingState());
    // areaList = [];
    var result = await getIt.get<AddEditPostRepo>().fetchAllArea(context);
    result.fold((failure) {
      print(failure.errMassage);

      emit(GetAllAreaFailureState(failure.errMassage));
    }, (areaList) {
      this.areaList = areaList;
      // print("dsfsdfsdf");
      emit(GetAllAreaSuccessState());
    });
  }

  void selectedArea(int index, bool selected) {
    selectAll = false;
    areaList[index].selected = selected;
    emit(GetAllAreaSuccessState());
  }

  void selectAllArea(bool selected) {
    selectAll = selected;
    for (var element in areaList) {
      element.selected = selectAll;
    }
    emit(GetAllAreaSuccessState());
  }
}
