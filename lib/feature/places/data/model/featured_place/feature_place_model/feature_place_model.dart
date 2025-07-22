import 'place_image.dart';

class FeaturePlaceModel {
  int? id;
  int? weekdayPrice;
  int? weekendPrice;
  String? title;
  String? address;
  String? area;
  String? tag;
  DateTime? createdAt;
  String? rating;
  List<PlaceImage>? placeImages;

  FeaturePlaceModel({
    this.id,
    this.weekdayPrice,
    this.weekendPrice,
    this.title,
    this.address,
    this.area,
    this.tag,
    this.createdAt,
    this.rating,
    this.placeImages,
  });

  factory FeaturePlaceModel.fromJson(Map<String, dynamic> json) {
    return FeaturePlaceModel(
      id: json['id'] as int?,
      weekdayPrice: json['weekday_price'] as int?,
      weekendPrice: json['weekend_price'] as int?,
      title: json['title'] as String?,
      address: json['address'] as String?,
      area: json['area'] as String?,
      tag: json['tag'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      rating: json['rating'] as String?,
      placeImages: (json['place_images'] as List<dynamic>?)
          ?.map((e) => PlaceImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'weekday_price': weekdayPrice,
        'weekend_price': weekendPrice,
        'title': title,
        'address': address,
        'area': area,
        'tag': tag,
        'created_at': createdAt?.toIso8601String(),
        'rating': rating,
        'place_images': placeImages?.map((e) => e.toJson()).toList(),
      };
}
