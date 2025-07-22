class PlaceReservationDataModel {
  int? id;
  String? status;
  num? totalPrice;
  DateTime? startingDate;
  DateTime? endingDate;
  String? placeTitle;
  String? categoryTitle;

  PlaceReservationDataModel({
    this.id,
    this.status,
    this.totalPrice,
    this.startingDate,
    this.endingDate,
    this.placeTitle,
    this.categoryTitle,
  });

  factory PlaceReservationDataModel.fromJson(Map<String, dynamic> json) {
    return PlaceReservationDataModel(
      id: json['id'] as int?,
      status: json['status'] as String?,
      totalPrice: json['total_price'] as num?,
      startingDate: json['starting_date'] == null
          ? null
          : DateTime.parse(json['starting_date'] as String),
      endingDate: json['ending_date'] == null
          ? null
          : DateTime.parse(json['ending_date'] as String),
      placeTitle: json['place_title'] as String?,
      categoryTitle: json['category_title'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'total_price': totalPrice,
        'starting_date': startingDate,
        'ending_date': endingDate,
        'place_title': placeTitle,
        'category_title': categoryTitle,
      };
}
