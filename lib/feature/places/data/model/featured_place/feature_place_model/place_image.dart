class PlaceImage {
  int? id;
  String? image;
  int? placeId;

  PlaceImage({this.id, this.image, this.placeId});

  factory PlaceImage.fromJson(Map<String, dynamic> json) => PlaceImage(
        id: json['id'] as int?,
        image: json['image'] as String?,
        placeId: json['place_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'place_id': placeId,
      };
}
