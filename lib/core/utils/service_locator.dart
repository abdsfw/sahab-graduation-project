import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sahab/core/utils/api_service.dart';
import 'package:sahab/feature/Bookings/data/repo/booking_repo.dart';
import 'package:sahab/feature/Bookings/data/repo/booking_repo_impl.dart';
import 'package:sahab/feature/account/data/repo/account_repo.dart';
import 'package:sahab/feature/account/data/repo/account_repo_impl.dart';
import 'package:sahab/feature/add_edit_post/data/repo/add_edit_post_repo.dart';
import 'package:sahab/feature/add_edit_post/data/repo/add_edit_post_repo_impl.dart';
import 'package:sahab/feature/auth/data/repositories/auth_repo.dart';
import 'package:sahab/feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:sahab/feature/categories/data/repo/category_repo.dart';
import 'package:sahab/feature/categories/data/repo/category_repo_impl.dart';
import 'package:sahab/feature/checkout/data/repo/checkout_repo.dart';
import 'package:sahab/feature/checkout/data/repo/checkout_repo_impl.dart';
import 'package:sahab/feature/home/data/repo/home_repo.dart';
import 'package:sahab/feature/home/data/repo/home_repo_impl.dart';
import 'package:sahab/feature/places/data/repo/place_repo.dart';
import 'package:sahab/feature/places/data/repo/place_repo_impl.dart';
import 'package:sahab/feature/reservations/data/repo/reservation_repo.dart';
import 'package:sahab/feature/reservations/data/repo/reservation_repo_impl.dart';
import 'package:sahab/feature/serach/data/repo/search_repo.dart';
import 'package:sahab/feature/serach/data/repo/search_repo_impl.dart';
import 'package:sahab/feature/services/data/repo/services_repo.dart';
import 'package:sahab/feature/services/data/repo/services_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: "https://sahab.ghinashop.net/api",
      ),
    ),
  );

  getIt.registerSingleton<ApiService>(
    ApiService(
      getIt.get<Dio>(),
    ),
  );

  getIt.registerSingleton<AuthRepo>(AuthRepoImpl());
  getIt.registerSingleton<AddEditPostRepo>(AddEditPostRepoImpl());
  getIt.registerSingleton<CategoryRepo>(CategoryRepoImpl());
  getIt.registerSingleton<PlaceRepo>(PlaceRepoImpl());
  getIt.registerSingleton<ServicesRepo>(ServicesRepoImpl());
  getIt.registerSingleton<AccountRepo>(AccountRepoImpl());
  getIt.registerSingleton<SearchRepo>(SearchRepoImpl());
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl());
  getIt.registerSingleton<BookingRepo>(BookingRepoImpl());
  getIt.registerSingleton<ReservationRepo>(ReservationRepoImpl());
  getIt.registerSingleton<CheckoutRepo>(CheckoutRepoImpl());
}
