import 'amenity.dart';
import 'place_image.dart';

class PlaceModel {
  String? image;
  int? id;
  num? weekdayPrice;
  String? title;
  String? address;
  String? tag;
  String? description;
  DateTime? createdAt;
  String? rating;
  List<PlaceImage>? placeImages;
  List<Amenity>? amenities;

  PlaceModel({
    this.image,
    this.id,
    this.weekdayPrice,
    this.title,
    this.address,
    this.tag,
    this.description,
    this.createdAt,
    this.rating,
    this.placeImages,
    this.amenities,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        image: json['image'] as String?,
        id: json['id'] as int?,
        weekdayPrice: json['weekday_price'] as num?,
        title: json['title'] as String?,
        address: json['address'] as String?,
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
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'id': id,
        'weekday_price': weekdayPrice,
        'title': title,
        'address': address,
        'tag': tag,
        'description': description,
        'created_at': createdAt?.toIso8601String(),
        'rating': rating,
        'place_images': placeImages?.map((e) => e.toJson()).toList(),
        'amenities': amenities?.map((e) => e.toJson()).toList(),
      };
}
