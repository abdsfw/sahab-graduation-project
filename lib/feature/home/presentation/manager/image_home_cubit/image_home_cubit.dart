import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/home/data/repo/home_repo.dart';
import 'package:sahab/feature/places/data/model/place_details_model.dart';
import 'package:sahab/feature/places/data/model/place_details_model/place_image.dart';

part 'image_home_state.dart';

class ImageHomeCubit extends Cubit<ImageHomeState> {
  ImageHomeCubit() : super(ImageHomeInitial());
  static ImageHomeCubit get(context) => BlocProvider.of(context);
  List<PlaceImage> listHomeImage = [];
  Future<void> getHomePic() async {
    emit(ImageHomeLoading());
    Either<Failure, List<PlaceImage>> result =
        await getIt.get<HomeRepo>().getHomePic();
    result.fold((error) {
      emit(ImageHomeFailure(errMessage: error.errMassage));
    }, (images) {
      listHomeImage = images;
      emit(ImageHomeSuccess());
    });
  }
}
