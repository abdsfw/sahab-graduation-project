import 'bookings.dart';

class BookingDetailsServiceModel {
  Bookings? bookings;
  dynamic userRating;
  bool? showButton;
  bool? canRate;
  bool? canCancel;

  BookingDetailsServiceModel({
    this.bookings,
    this.userRating,
    this.showButton,
    this.canRate,
    this.canCancel,
  });

  factory BookingDetailsServiceModel.fromJson(Map<String, dynamic> json) {
    return BookingDetailsServiceModel(
      bookings: json['bookings'] == null
          ? null
          : Bookings.fromJson(json['bookings'] as Map<String, dynamic>),
      userRating: json['user_rating'] as dynamic,
      showButton: json['showButton'] as bool?,
      canRate: json['can_rate'] as bool?,
      canCancel: json['can_cancel'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'bookings': bookings?.toJson(),
        'user_rating': userRating,
        'showButton': showButton,
        'can_rate': canRate,
        'can_cancel': canCancel,
      };
}
