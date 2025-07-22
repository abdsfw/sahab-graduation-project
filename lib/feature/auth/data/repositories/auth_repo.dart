import 'package:dartz/dartz.dart';
import 'package:sahab/core/errors/failures.dart';
import 'package:sahab/feature/auth/data/models/login_model/login_model.dart';
import 'package:sahab/feature/auth/data/models/new_login_model/new_login_model.dart';
import 'package:sahab/feature/auth/data/models/register/register_model.dart';
import 'package:sahab/feature/auth/data/models/skip_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, NewRegisterModel>> register(User user);
  Future<Either<Failure, NewLoginModel>> login(LoginModel user);
  Future<Either<Failure, String>> sendOtp(Map<String, dynamic> data);
  Future<Either<Failure, String>> reSendOtp(Map<String, dynamic> data);
  Future<Either<Failure, Tuple2<NewLoginModel, bool>>> loginWithOtp(
      Map<String, dynamic> data);
  Future<Either<Failure, SkipModel>> getSkipPhoto();
}
