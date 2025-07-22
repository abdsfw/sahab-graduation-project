import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/service_locator.dart';
import 'package:sahab/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab/feature/home/data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  final controller = PageController();

  Future<void> fetchUserData(context) async {
    emit(LoadingFetchUserData());
    var result = await getIt.get<HomeRepo>().checkUserRole();
    result.fold((error) {
      emit(FailureFetchUserData());
    }, (response) async {
      await CacheHelper.setData(
          key: Constant.kUserEmail, value: response.email);
      await CacheHelper.setData(key: Constant.kUserName, value: response.name);
      await CacheHelper.setData(key: Constant.kUserRole, value: response.role);
      await CacheHelper.setData(
          key: Constant.kUserPhoneNumber, value: response.phone);
      BlocProvider.of<AccountCubit>(context).setAllUserInfo();
      emit(SuccessFetchUserData());
    });
  }

  // Future<Widget> _futureSvgOrError(
  //     Widget errorWidget, String svgAssetUrl) async {
  //   try {
  //     final svgAsset = await getIt
  //         .get<HomeRepo>()
  //         .fetchSvgData(url: svgAssetUrl); // http exception
  //     await SvgParser()
  //         .parse(svgAsset, warningsAsErrors: true); // rendering exception
  //     return SvgPicture.string(
  //       svgAsset,
  //       height: 40,
  //       fit: BoxFit.cover,
  //     );
  //   } catch (e) {
  //     debugPrint('WARN: Error occured while loading asset $svgAssetUrl: $e');
  //     return errorWidget;
  //   }
  // }
}
