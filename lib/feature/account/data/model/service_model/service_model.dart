import 'package:sahab/feature/account/data/model/service_model/category.dart';

import 'available_time.dart';
import 'service_image.dart';

class ServiceModel {
  int? id;
  num? price;
  String? title;
  int? duration;
  String? tag;
  String? description;
  String? rating;
  String? noticePeriod;
  num? maxCapacity;
  Category? category;
  List<ServiceImage>? serviceImages;
  // List<AvailableTime>? availableTimes;

  ServiceModel({
    this.id,
    this.price,
    this.title,
    this.duration,
    this.tag,
    this.noticePeriod,
    this.maxCapacity,
    this.category,
    this.description,
    this.rating,
    this.serviceImages,
    // this.availableTimes,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json['id'] as int?,
        price: json['price'] as num?,
        title: json['title'] as String?,
        duration: json['duration'] as int?,
        tag: json['tag'] as String?,
        noticePeriod: json['notice_period'] as String?,
        maxCapacity: json['max_capacity'] as num?,
        description: json['description'] as String?,
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category'] as Map<String, dynamic>),
        rating: json['rating'] as String?,
        serviceImages: (json['service_images'] as List<dynamic>?)
            ?.map((e) => ServiceImage.fromJson(e as Map<String, dynamic>))
            .toList(),
        // availableTimes: (json['available_times'] as List<dynamic>?)
        //     ?.map((e) => AvailableTime.fromJson(e as Map<String, dynamic>))
        //     .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'title': title,
        'duration': duration,
        'tag': tag,
        'description': description,
        'rating': rating,
        'service_images': serviceImages?.map((e) => e.toJson()).toList(),
        // 'available_times': availableTimes?.map((e) => e.toJson()).toList(),
      };
}
