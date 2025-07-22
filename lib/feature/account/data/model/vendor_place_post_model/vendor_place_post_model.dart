import 'place_image.dart';

class VendorPlacePostModel {
  int? id;
  num? weekdayPrice;
  num? weekendPrice;
  String? title;
  bool? available;
  String? address;
  int? featured;
  bool? bookable;
  String? area;
  String? tag;
  DateTime? createdAt;
  String? rating;
  List<PlaceImage>? placeImages;
  // List<dynamic>? bookings;

  VendorPlacePostModel({
    this.id,
    this.weekdayPrice,
    this.weekendPrice,
    this.title,
    this.available,
    this.address,
    this.featured,
    this.bookable,
    this.area,
    this.tag,
    this.createdAt,
    this.rating,
    this.placeImages,
    // this.bookings,
  });

  factory VendorPlacePostModel.fromJson(Map<String, dynamic> json) {
    return VendorPlacePostModel(
      id: json['id'] as int?,
      weekdayPrice: json['weekday_price'] as num?,
      weekendPrice: json['weekend_price'] as num?,
      title: json['title'] as String?,
      available: json['available'] == 1 ? true : false as bool?,
      address: json['address'] as String?,
      featured: json['featured'] as int?,
      bookable: json['bookable'] == 1 ? true : false as bool?,
      area: json['area'] as String?,
      tag: json['tag'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      rating: json['rating'] as String?,
      placeImages: (json['place_images'] as List<dynamic>?)
          ?.map((e) => PlaceImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      // bookings: json['bookings'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'weekday_price': weekdayPrice,
        'weekend_price': weekendPrice,
        'title': title,
        'available': available,
        'address': address,
        'featured': featured,
        'bookable': bookable,
        'area': area,
        'tag': tag,
        'created_at': createdAt?.toIso8601String(),
        'rating': rating,
        'place_images': placeImages?.map((e) => e.toJson()).toList(),
        // 'bookings': bookings,
      };
}
