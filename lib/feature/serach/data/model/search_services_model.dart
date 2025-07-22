class SearchServicesModel {
  final int id;
  final num price;
  final String title;
  final DateTime createdAt;
  final double rating;
  final List<ServiceImage>? serviceImages; // Nullable list

  SearchServicesModel({
    required this.id,
    required this.price,
    required this.title,
    required this.createdAt,
    required this.rating,
    required this.serviceImages,
  });

  factory SearchServicesModel.fromJson(Map<String, dynamic> json) {
    return SearchServicesModel(
      id: json['id'] ?? -1,
      price: json['price'],
      title: json['title'] ?? '',
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      rating: double.tryParse(json['rating'] ?? '0.0') ?? 0.0,
      serviceImages: json['place_images'] != null
          ? List<ServiceImage>.from(json['place_images']
              .map((imageJson) => ServiceImage.fromJson(imageJson)))
          : null,
    );
  }
}

class ServiceImage {
  final int id;
  final String image;
  final int placeId;

  ServiceImage({
    required this.id,
    required this.image,
    required this.placeId,
  });

  factory ServiceImage.fromJson(Map<String, dynamic> json) {
    return ServiceImage(
      id: json['id'] ?? -1,
      image: json['image'] ?? '',
      placeId: json['place_id'] ?? -1,
    );
  }
}
