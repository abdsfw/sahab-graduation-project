class ServicesModel {
  final String image;
  final int id;
  final num price;
  final int duration;
  final String title;
  final String? tag;
  final double rating;

  ServicesModel({
    required this.image,
    required this.id,
    required this.price,
    required this.duration,
    required this.title,
    this.tag,
    required this.rating,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      image: json['image'] ?? '',
      id: json['id'] ?? 0,
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
      duration: json['duration'] ?? 0,
      title: json['title'] ?? '',
      tag: json['tag'],
      rating: json['rating'] != null
          ? double.parse(json['rating'].toString())
          : 0.0,
    );
  }
}
