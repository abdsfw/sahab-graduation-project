class Pivot {
  int? placeId;
  int? amenityId;

  Pivot({this.placeId, this.amenityId});

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        placeId: json['place_id'] as int?,
        amenityId: json['amenity_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'place_id': placeId,
        'amenity_id': amenityId,
      };
}
