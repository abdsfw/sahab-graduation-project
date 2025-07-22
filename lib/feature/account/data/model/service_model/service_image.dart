class ServiceImage {
  int? id;
  String? image;
  int? serviceId;

  ServiceImage({this.id, this.image, this.serviceId});

  factory ServiceImage.fromJson(Map<String, dynamic> json) => ServiceImage(
        id: json['id'] as int?,
        image: json['image'] as String?,
        serviceId: json['service_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'service_id': serviceId,
      };
}
