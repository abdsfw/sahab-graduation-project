class ServiceReservationDetailsModel {
  int? id;
  DateTime? createdAt;
  String? status;
  String? address;
  num? totalPrice;
  DateTime? startingDate;
  DateTime? endingDate;
  String? transactionId;
  String? invoiceReference;
  String? referenceId;
  num? payment;
  String? paymentMethod;
  String? serviceTitle;
  num? price;
  String? categoryTitle;
  String? name;
  String? phone;
  num? discount;
  num? total;
  List<dynamic>? images;
  String? rating;

  ServiceReservationDetailsModel({
    this.id,
    this.createdAt,
    this.status,
    this.address,
    this.totalPrice,
    this.startingDate,
    this.endingDate,
    this.transactionId,
    this.invoiceReference,
    this.referenceId,
    this.payment,
    this.paymentMethod,
    this.serviceTitle,
    this.price,
    this.categoryTitle,
    this.name,
    this.phone,
    this.discount,
    this.total,
    this.images,
    this.rating,
  });

  factory ServiceReservationDetailsModel.fromJson(Map<String, dynamic> json) {
    return ServiceReservationDetailsModel(
      id: json['id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      status: json['status'] as String?,
      address: json['address'] as String?,
      totalPrice: json['total_price'] as num?,
      startingDate: json['starting_date'] == null
          ? null
          : DateTime.parse(json['starting_date'] as String),
      endingDate: json['ending_date'] == null
          ? null
          : DateTime.parse(json['ending_date'] as String),
      transactionId: json['transaction_id'] as String?,
      invoiceReference: json['invoice_reference'] as String?,
      referenceId: json['reference_id'] as String?,
      payment: json['payment'] as num?,
      paymentMethod: json['payment_method'] as String?,
      serviceTitle: json['service_title'] as String?,
      price: json['price'] as num?,
      categoryTitle: json['category_title'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      discount: json['discount'] as num?,
      total: json['total'] as num?,
      images: json['images'] as List<dynamic>?,
      rating: json['rating'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'status': status,
        'address': address,
        'total_price': totalPrice,
        'starting_date': startingDate,
        'ending_date': endingDate,
        'transaction_id': transactionId,
        'invoice_reference': invoiceReference,
        'reference_id': referenceId,
        'payment': payment,
        'payment_method': paymentMethod,
        'service_title': serviceTitle,
        'price': price,
        'category_title': categoryTitle,
        'name': name,
        'phone': phone,
        'discount': discount,
        'total': total,
        'images': images,
        'rating': rating,
      };
}
