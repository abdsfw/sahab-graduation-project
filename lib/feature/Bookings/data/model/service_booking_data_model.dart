class ServiceBookingDataModel {
  int? id;
  String? status;
  num? totalPrice;
  String? serviceTitle;
  String? categoryTitle;

  ServiceBookingDataModel({
    this.id,
    this.status,
    this.totalPrice,
    this.serviceTitle,
    this.categoryTitle,
  });

  factory ServiceBookingDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceBookingDataModel(
      id: json['id'] as int?,
      status: json['status'] as String?,
      totalPrice: json['total_price'] as num?,
      serviceTitle: json['service_title'] as String?,
      categoryTitle: json['category_title'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'total_price': totalPrice,
        'service_title': serviceTitle,
        'category_title': categoryTitle,
      };
}
