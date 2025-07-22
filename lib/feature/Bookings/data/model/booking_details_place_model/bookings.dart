class Bookings {
  num? id;
  DateTime? createdAt;
  String? status;
  num? totalPrice;
  DateTime? startingDate;
  DateTime? endingDate;
  String? transactionId;
  String? invoiceReference;
  String? referenceId;
  num? payment;
  String? paymentMethod;
  String? placeTitle;
  String? tag;
  num? weekdayPrice;
  num? weekendPrice;
  String? address;
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
    this.totalPrice,
    this.startingDate,
    this.endingDate,
    this.transactionId,
    this.invoiceReference,
    this.referenceId,
    this.payment,
    this.paymentMethod,
    this.placeTitle,
    this.tag,
    this.weekdayPrice,
    this.weekendPrice,
    this.address,
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
        totalPrice: json['total_price'] as num?,
        startingDate: json['starting_date'] == null
            ? null
            : DateTime.parse(json['starting_date'] as String),
        // startingDate: json['starting_date'] as String?,
        endingDate: json['ending_date'] == null
            ? null
            : DateTime.parse(json['ending_date'] as String),
        // endingDate: json['ending_date'] as String?,
        transactionId: json['transaction_id'] as String?,
        invoiceReference: json['invoice_reference'] as String?,
        referenceId: json['reference_id'] as String?,
        payment: json['payment'] as num?,
        paymentMethod: json['payment_method'] as String?,
        placeTitle: json['place_title'] as String?,
        tag: json['tag'] as String?,
        weekdayPrice: json['weekday_price'] as num?,
        weekendPrice: json['weekend_price'] as num?,
        address: json['address'] as String?,
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
        'total_price': totalPrice,
        'starting_date': startingDate,
        'ending_date': endingDate,
        'transaction_id': transactionId,
        'invoice_reference': invoiceReference,
        'reference_id': referenceId,
        'payment': payment,
        'payment_method': paymentMethod,
        'place_title': placeTitle,
        'tag': tag,
        'weekday_price': weekdayPrice,
        'weekend_price': weekendPrice,
        'address': address,
        'category_title': categoryTitle,
        'name': name,
        'phone': phone,
        'discount': discount,
        'total': total,
        'images': images,
        'rating': rating,
      };
}
