class Bookings {
  num? id;
  DateTime? createdAt;
  String? status;
  dynamic address;
  num? totalPrice;
  String? transactionId;
  String? referenceId;
  String? invoiceReference;
  num? payment;
  String? paymentMethod;
  DateTime? startingDate;
  DateTime? endingDate;
  String? serviceTitle;
  num? price;
  String? categoryTitle;
  String? name;
  String? phone;
  num? discount;
  num? total;
  List<dynamic>? images;
  String? rating;

  Bookings({
    this.id,
    this.createdAt,
    this.status,
    this.address,
    this.totalPrice,
    this.transactionId,
    this.referenceId,
    this.invoiceReference,
    this.payment,
    this.paymentMethod,
    this.startingDate,
    this.endingDate,
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

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
        id: json['id'] as num?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        status: json['status'] as String?,
        address: json['address'] as dynamic,
        totalPrice: json['total_price'] as num?,
        transactionId: json['transaction_id'] as String?,
        referenceId: json['reference_id'] as String?,
        invoiceReference: json['invoice_reference'] as String?,
        payment: json['payment'] as num?,
        paymentMethod: json['payment_method'] as String?,
        startingDate: json['starting_date'] == null
            ? null
            : DateTime.parse(json['starting_date'] as String),
        // startingDate: json['starting_date'] as String?,
        endingDate: json['ending_date'] == null
            ? null
            : DateTime.parse(json['ending_date'] as String),
        // endingDate: json['ending_date'] as String?,
        serviceTitle: json['service_title'] as String?,
        price: json['price'] as num?,
        categoryTitle: json['category_title'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        discount: json['discount'] as num?,
        total: json['total'] as num?,
        images: json['images'],
        rating: json['rating'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'status': status,
        'address': address,
        'total_price': totalPrice,
        'transaction_id': transactionId,
        'reference_id': referenceId,
        'invoice_reference': invoiceReference,
        'payment': payment,
        'payment_method': paymentMethod,
        'starting_date': startingDate,
        'ending_date': endingDate,
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
