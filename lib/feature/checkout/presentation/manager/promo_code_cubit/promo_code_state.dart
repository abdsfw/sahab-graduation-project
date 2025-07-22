part of 'promo_code_cubit.dart';

sealed class PromoCodeState extends Equatable {
  const PromoCodeState();

  @override
  List<Object> get props => [];
}

final class PromoCodeInitial extends PromoCodeState {}

final class LoadingPromoCode extends PromoCodeState {}

final class FailurePromoCode extends PromoCodeState {}

final class SuccessPromoCode extends PromoCodeState {}
