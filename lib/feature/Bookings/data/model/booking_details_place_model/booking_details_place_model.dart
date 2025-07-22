import 'bookings.dart';

class BookingDetailsPlaceModel {
  Bookings? bookings;
  dynamic userRating;
  bool? showButton;
  bool? canRate;
  bool? canCancel;

  BookingDetailsPlaceModel({
    this.bookings,
    this.userRating,
    this.showButton,
    this.canRate,
    this.canCancel,
  });

  factory BookingDetailsPlaceModel.fromJson(Map<String, dynamic> json) {
    return BookingDetailsPlaceModel(
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
