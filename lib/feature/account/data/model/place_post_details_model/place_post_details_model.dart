import 'package:sahab/feature/account/data/model/place_post_details_model/category.dart';

import 'amenity.dart';
import 'booking.dart';
import 'place_image.dart';
import 'special_day.dart';

class PlacePostDetailsModel {
  int? id;
  num? weekdayPrice;
  num? weekendPrice;
  String? title;
  int? bookable;
  int? available;
  String? address;
  String? area;
  String? tag;
  String? description;
  DateTime? createdAt;
  String? rating;
  Category? category;
  List<PlaceImage>? placeImages;
  List<Amenity>? amenities;
  // List<Booking>? bookings;
  List<SpecialDay>? specialDays;

  PlacePostDetailsModel({
    this.id,
    this.weekdayPrice,
    this.weekendPrice,
    this.title,
    this.bookable,
    this.available,
    this.address,
    this.area,
    this.tag,
    this.description,
    this.createdAt,
    this.rating,
    this.placeImages,
    this.amenities,
    this.category,
    // this.bookings,
    this.specialDays,
  });

  factory PlacePostDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlacePostDetailsModel(
      id: json['id'] as int?,
      weekdayPrice: json['weekday_price'] as num?,
      weekendPrice: json['weekend_price'] as num?,
      title: json['title'] as String?,
      bookable: json['bookable'] as int?,
      available: json['available'] as int?,
      address: json['address'] as String?,
      area: json['area'] as String?,
      tag: json['tag'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      rating: json['rating'] as String?,
      placeImages: (json['place_images'] as List<dynamic>?)
          ?.map((e) => PlaceImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => Amenity.fromJson(e as Map<String, dynamic>))
          .toList(),
      // bookings: (json['bookings'] as List<dynamic>?)
      //     ?.map((e) => Booking.fromJson(e as Map<String, dynamic>))
      //     .toList(),
      specialDays: (json['special_days'] as List<dynamic>?)
          ?.map((e) => SpecialDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'weekday_price': weekdayPrice,
        'weekend_price': weekendPrice,
        'title': title,
        'bookable': bookable,
        'available': available,
        'address': address,
        'area': area,
        'tag': tag,
        'description': description,
        'created_at': createdAt?.toIso8601String(),
        'rating': rating,
        'category': category?.toJson(),
        'place_images': placeImages?.map((e) => e.toJson()).toList(),
        'amenities': amenities?.map((e) => e.toJson()).toList(),
        // 'bookings': bookings?.map((e) => e.toJson()).toList(),
        'special_days': specialDays?.map((e) => e.toJson()).toList(),
      };
}
