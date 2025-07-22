class PlaceBookingDataModel {
  int? id;
  String? status;
  num? totalPrice;
  String? placeTitle;
  String? categoryTitle;

  PlaceBookingDataModel({
    this.id,
    this.status,
    this.totalPrice,
    this.placeTitle,
    this.categoryTitle,
  });

  factory PlaceBookingDataModel.fromJson(Map<String, dynamic> json) {
    return PlaceBookingDataModel(
      id: json['id'] as int?,
      status: json['status'] as String?,
      totalPrice: json['total_price'] as num?,
      placeTitle: json['place_title'] as String?,
      categoryTitle: json['category_title'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'total_price': totalPrice,
        'place_title': placeTitle,
        'category_title': categoryTitle,
      };
}
