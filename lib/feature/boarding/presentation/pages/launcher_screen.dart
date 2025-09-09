import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahab/core/const.dart';
import 'package:sahab/core/notifiction/notification_cubit/notification_cubit.dart';
import 'package:sahab/core/utils/cache/cache_helper.dart';
import 'package:sahab/core/utils/widgets/no_internet_page.dart';
import 'package:sahab/feature/account/presentation/manager/account_cubit/account_cubit.dart';
import 'package:sahab/feature/auth/presentation/pages/login/login_screen.dart';
import 'package:sahab/feature/boarding/presentation/manager/internet_cubit/connectivity_cubit.dart';
import 'package:sahab/feature/boarding/presentation/manager/skip_cubit/skip_cubit.dart';
import 'package:sahab/feature/boarding/presentation/pages/lang_screen.dart';
import 'package:sahab/feature/boarding/presentation/pages/skip_screen.dart';
import 'package:sahab/feature/home/presentation/pages/home_page_view.dart';
import '../../../../core/utils/images/app_images_path.dart';
import '../../../../core/utils/logo/logos_app.dart';
import '../../../../core/utils/widgets/background_app.dart';

// @RoutePage()
class LauncherScreen extends StatefulWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    BlocProvider.of<SkipCubit>(context).getSkipPhoto(context);
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      BlocProvider.of<ConnectivityCubit>(context).checkInternetStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocConsumer<ConnectivityCubit, ConnectivityStatus>(
        listener: (context, state) async {
          if (state == ConnectivityStatus.disconnected) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => NoInternetView(),
              ),
              (route) {
                return false;
              },
            );
          } else if (state == ConnectivityStatus.connected) {
            if (CacheHelper.getData(key: Constant.kIsFirstTime) == null ||
                CacheHelper.getData(key: Constant.kIsFirstTime) == true) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LangScreen()),
                (route) => false,
              );
            } else {
              String? role = await CacheHelper.getData(key: Constant.kUserRole);

              if (CacheHelper.getData(key: Constant.kIsRegister) == true ||
                  role == "guest") {
                //? this call for set user info into cubit
                BlocProvider.of<AccountCubit>(context).setUserInfo();
                if (role != "guest") {
                  BlocProvider.of<NotificationCubit>(context)
                      .sendNotificationToken();
                }
                //? --------------------------------------
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageView()),
                  (route) => false,
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HomePageView(),
                //   ),
                // );
              }
              //!endIf isRegister
              else {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => LoginScreen(),
                //   ),
                // );
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              }
              //!endElse isRegister
            }

            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => SkipScreen(),
            //   ),
            //   (route) {
            //     return false;
            //   },
            // );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              BackgroundApp(
                widget: Center(
                  child: Image.asset(
                    LogoApp.layer1,
                    width: 186.w,
                    height: 202.72.h,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Image.asset(
                  AppImagesPath.boardingLogo,
                  width: w,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
