class SearchPlaceModel {
  final int id;
  final int weekdayPrice;
  final int weekendPrice;
  final String title;
  final String address;
  final String tag;
  final DateTime createdAt;
  final double rating;
  final List<PlaceImage>? placeImages; // Nullable list

  SearchPlaceModel({
    required this.id,
    required this.weekdayPrice,
    required this.weekendPrice,
    required this.title,
    required this.address,
    required this.tag,
    required this.createdAt,
    required this.rating,
    this.placeImages,
  });

  factory SearchPlaceModel.fromJson(Map<String, dynamic> json) {
    return SearchPlaceModel(
      id: json['id'] ?? -1,
      weekdayPrice: json['weekday_price'] ?? 0,
      weekendPrice: json['weekend_price'] ?? 0,
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      tag: json['tag'] ?? '',
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      rating: double.tryParse(json['rating'] ?? '0.0') ?? 0.0,
      placeImages: json['place_images'] != null
          ? List<PlaceImage>.from(json['place_images']
              .map((imageJson) => PlaceImage.fromJson(imageJson)))
          : null,
    );
  }
}

class PlaceImage {
  final int id;
  final String image;
  final int placeId;

  PlaceImage({
    required this.id,
    required this.image,
    required this.placeId,
  });

  factory PlaceImage.fromJson(Map<String, dynamic> json) {
    return PlaceImage(
      id: json['id'] ?? -1,
      image: json['image'] ?? '',
      placeId: json['place_id'] ?? -1,
    );
  }
}
