// class PlaceDetailsModel {
//   String? image;
//   int? id;
//   int? weekdayPrice;
//   String? title;
//   String? address;
//   String? tag;
//   String? description;
//   String? createdAt;
//   String? rating;
//   List<PlaceImage>? placeImages;
//   List<Amenity>? amenities;

//   PlaceDetailsModel(
//       {this.image,
//       this.id,
//       this.weekdayPrice,
//       this.title,
//       this.address,
//       this.tag,
//       this.description,
//       this.createdAt,
//       this.rating,
//       this.placeImages,
//       this.amenities});

//   PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//     id = json['id'];
//     weekdayPrice = json['weekday_price'];
//     title = json['title'];
//     address = json['address'];
//     tag = json['tag'];
//     description = json['description'];
//     createdAt = json['created_at'];
//     rating = json['rating'];
//     if (json['place_images'] != null) {
//       placeImages = <PlaceImage>[];
//       json['place_images'].forEach((v) {
//         placeImages!.add(PlaceImage.fromJson(v));
//       });
//     }
//     if (json['amenities'] != null) {
//       amenities = <Amenity>[];
//       json['amenities'].forEach((v) {
//         amenities!.add(Amenity.fromJson(v));
//       });
//     }
//   }
// }

// class PlaceImage {
//   int? id;
//   String? image;
//   int? placeId;

//   PlaceImage({this.id, this.image, this.placeId});

//   PlaceImage.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     image = json['image'];
//     // placeId = json['place_id'];
//   }
// }

// class Amenity {
//   int? id;
//   String? title;
//   String? icon;

//   Amenity({this.id, this.title, this.icon});

//   Amenity.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     icon = json['icon'];
//   }
// }
