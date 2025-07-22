import 'service_image.dart';

class VendorServicePostModel {
  int? id;
  num? price;
  String? title;
  int? duration;
  bool? bookable;
  bool? available;
  int? featured;
  DateTime? createdAt;
  String? rating;
  List<ServiceImage>? serviceImages;
  // List<dynamic>? bookings;

  VendorServicePostModel({
    this.id,
    this.price,
    this.title,
    this.duration,
    this.bookable,
    this.available,
    this.featured,
    this.createdAt,
    this.rating,
    this.serviceImages,
    // this.bookings,
  });

  factory VendorServicePostModel.fromJson(Map<String, dynamic> json) {
    return VendorServicePostModel(
      id: json['id'] as int?,
      price: json['price'] as num?,
      title: json['title'] as String?,
      duration: json['duration'] as int?,
      bookable: json['bookable'] == 1 ? true : false as bool?,
      available: json['available'] == 1 ? true : false as bool?,
      featured: json['featured'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      rating: json['rating'] as String?,
      serviceImages: (json['service_images'] as List<dynamic>?)
          ?.map((e) => ServiceImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      // bookings: json['bookings'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'title': title,
        'duration': duration,
        'bookable': bookable,
        'available': available,
        'featured': featured,
        'created_at': createdAt?.toIso8601String(),
        'rating': rating,
        'service_images': serviceImages?.map((e) => e.toJson()).toList(),
        // 'bookings': bookings,
      };
}
