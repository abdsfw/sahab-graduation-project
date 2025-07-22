class PlaceImage {
  int? id;
  String? image;
  int? placeId;

  PlaceImage({this.id, this.image, this.placeId});

  PlaceImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    // placeId = json['place_id'];
  }
}
