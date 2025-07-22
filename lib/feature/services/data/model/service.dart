class Services {
  final int id;
  final double price;
  final String title;
  final int duration;
  final String tag;
  final DateTime createdAt;
  final String rating;
  final List<ServiceImage> serviceImages;

  Services({
    required this.id,
    required this.price,
    required this.title,
    required this.duration,
    required this.tag,
    required this.createdAt,
    required this.rating,
    required this.serviceImages,
  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['id'] ?? 0,
      price: json['price']?.toDouble() ?? 0.0,
      title: json['title'] ?? '',
      duration: json['duration'] ?? 0,
      tag: json['tag'] ?? '',
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      rating: json['rating'],
      serviceImages: (json['service_images'] as List<dynamic>?)
              ?.map((imageJson) => ServiceImage.fromJson(imageJson))
              .toList() ??
          [],
    );
  }
}

class ServiceImage {
  final int id;
  final String image;
  final int serviceId;

  ServiceImage({
    required this.id,
    required this.image,
    required this.serviceId,
  });

  factory ServiceImage.fromJson(Map<String, dynamic> json) {
    return ServiceImage(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      serviceId: json['service_id'] ?? 0,
    );
  }
}
