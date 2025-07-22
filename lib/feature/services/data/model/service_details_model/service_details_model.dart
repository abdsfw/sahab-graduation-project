import 'service_image.dart';

class ServiceDetailsModel {
  int? id;
  num? price;
  String? title;
  int? duration;
  String? description;
  int? bookable;
  int? featured;
  DateTime? createdAt;
  String? rating;
  List<ServiceImage>? serviceImages;
  // List<dynamic>? bookings;

  ServiceDetailsModel({
    this.id,
    this.price,
    this.title,
    this.duration,
    this.description,
    this.bookable,
    this.featured,
    this.createdAt,
    this.rating,
    this.serviceImages,
    // this.bookings,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailsModel(
      id: json['id'] as int?,
      price: json['price'] as num?,
      title: json['title'] as String?,
      duration: json['duration'] as int?,
      description: json['description'] as String?,
      bookable: json['bookable'] as int?,
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
        'description': description,
        'bookable': bookable,
        'featured': featured,
        'created_at': createdAt?.toIso8601String(),
        'rating': rating,
        'service_images': serviceImages?.map((e) => e.toJson()).toList(),
        // 'bookings': bookings,
      };
}
