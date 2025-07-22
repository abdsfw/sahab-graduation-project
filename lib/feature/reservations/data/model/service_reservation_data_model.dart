class ServiceReservationDataModel {
  int? id;
  String? status;
  num? totalPrice;
  num? payment;
  String? invoiceReference;
  DateTime? startingDate;
  DateTime? endingDate;
  String? serviceTitle;
  String? categoryTitle;

  ServiceReservationDataModel({
    this.id,
    this.status,
    this.totalPrice,
    this.payment,
    this.invoiceReference,
    this.startingDate,
    this.endingDate,
    this.serviceTitle,
    this.categoryTitle,
  });

  factory ServiceReservationDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceReservationDataModel(
      id: json['id'] as int?,
      status: json['status'] as String?,
      totalPrice: json['total_price'] as num?,
      payment: json['payment'] as num?,
      invoiceReference: json['invoice_reference'] as String?,
      startingDate: json['starting_date'] == null
          ? null
          : DateTime.parse(json['starting_date'] as String),
      endingDate: json['ending_date'] == null
          ? null
          : DateTime.parse(json['ending_date'] as String),
      serviceTitle: json['service_title'] as String?,
      categoryTitle: json['category_title'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'total_price': totalPrice,
        'payment': payment,
        'invoice_reference': invoiceReference,
        'starting_date': startingDate,
        'ending_date': endingDate,
        'service_title': serviceTitle,
        'category_title': categoryTitle,
      };
}
