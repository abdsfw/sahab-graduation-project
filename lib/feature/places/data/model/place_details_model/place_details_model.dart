import 'package:sahab/feature/places/data/model/place_details_model/place_image.dart';
import 'package:sahab/feature/places/data/model/place_details_model/special_days.dart';

import 'amenity.dart';

class PlaceDetailsModel {
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
  List<PlaceImage>? placeImages;
  List<Amenity>? amenities;
  // List<dynamic>? bookings;
  List<SpecialDays>? specialDays;

  PlaceDetailsModel({
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
    // this.bookings,
    this.specialDays,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsModel(
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
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => Amenity.fromJson(e as Map<String, dynamic>))
          .toList(),
      // bookings: json['bookings'] as List<dynamic>?,
      specialDays: (json['special_days'] as List<dynamic>?)
          ?.map((e) => SpecialDays.fromJson(e as Map<String, dynamic>))
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
        'place_images': placeImages,
        'amenities': amenities?.map((e) => e.toJson()).toList(),
        // 'bookings': bookings,
        'special_days': specialDays?.map((e) => e.toJson()).toList(),
      };
}
