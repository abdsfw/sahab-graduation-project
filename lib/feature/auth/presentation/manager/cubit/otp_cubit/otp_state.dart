part of 'otp_cubit.dart';

sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpTimerFished extends OtpState {}

final class OtpTimerReset extends OtpState {}

final class OtpFailure extends OtpState {}

final class OtpSuccess extends OtpState {}

final class ResendOtpLoading extends OtpState {}

final class ResendOtpLSuccess extends OtpState {}

final class ResendOtpLFailure extends OtpState {}
