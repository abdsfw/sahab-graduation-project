class Booking {
  int? id;
  String? startingDate;
  String? endingDate;
  double? totalPrice;
  double? payment;
  dynamic address;
  String? status;
  String? transactionId;
  String? invoiceReference;
  String? referenceId;
  DateTime? createdAt;
  int? userId;
  dynamic promoCodeId;
  dynamic serviceId;
  int? placeId;
  int? paymentMethodId;
  List<dynamic>? ratings;

  Booking({
    this.id,
    this.startingDate,
    this.endingDate,
    this.totalPrice,
    this.payment,
    this.address,
    this.status,
    this.transactionId,
    this.invoiceReference,
    this.referenceId,
    this.createdAt,
    this.userId,
    this.promoCodeId,
    this.serviceId,
    this.placeId,
    this.paymentMethodId,
    this.ratings,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'] as int?,
        startingDate: json['starting_date'] as String?,
        endingDate: json['ending_date'] as String?,
        totalPrice: (json['total_price'] as num?)?.toDouble(),
        payment: (json['payment'] as num?)?.toDouble(),
        address: json['address'] as dynamic,
        status: json['status'] as String?,
        transactionId: json['transaction_id'] as String?,
        invoiceReference: json['invoice_reference'] as String?,
        referenceId: json['reference_id'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        userId: json['user_id'] as int?,
        promoCodeId: json['promo_code_id'] as dynamic,
        serviceId: json['service_id'] as dynamic,
        placeId: json['place_id'] as int?,
        paymentMethodId: json['payment_method_id'] as int?,
        ratings: json['ratings'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'starting_date': startingDate,
        'ending_date': endingDate,
        'total_price': totalPrice,
        'payment': payment,
        'address': address,
        'status': status,
        'transaction_id': transactionId,
        'invoice_reference': invoiceReference,
        'reference_id': referenceId,
        'created_at': createdAt?.toIso8601String(),
        'user_id': userId,
        'promo_code_id': promoCodeId,
        'service_id': serviceId,
        'place_id': placeId,
        'payment_method_id': paymentMethodId,
        'ratings': ratings,
      };
}
