class Place {
  int? id;
  num? weekdayPrice;
  num? weekendPrice;
  String? title;
  String? address;
  String? tag;
  DateTime? createdAt;
  double? rating;
  List<PlaceImage>? placeImages;

  Place({
    this.id,
    this.weekdayPrice,
    this.weekendPrice,
    this.title,
    this.address,
    this.tag,
    this.createdAt,
    this.rating,
    this.placeImages,
  });

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekdayPrice = json['weekday_price'] ?? 0;
    weekendPrice = json['weekend_price'] ?? 0;
    title = json['title'] ?? '';
    address = json['address'] ?? '';
    tag = json['tag'] ?? '';
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    rating =
        json['rating'] != null ? double.parse(json['rating'].toString()) : 0.0;

    if (json['place_images'] != null) {
      json['place_images'].map((v) {
        placeImages?.add(PlaceImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['weekday_price'] = this.weekdayPrice;
    data['weekend_price'] = this.weekendPrice;
    data['title'] = this.title;
    data['address'] = this.address;
    data['tag'] = this.tag;
    data['created_at'] = this.createdAt?.toIso8601String();
    data['rating'] = this.rating;
    if (this.placeImages != null) {
      data['place_images'] = this.placeImages?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlaceImage {
  int? id;
  String? image;
  int? placeId;

  PlaceImage({this.id, this.image, this.placeId});

  PlaceImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'] ?? '';
    placeId = json['place_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['place_id'] = this.placeId;
    return data;
  }
}
