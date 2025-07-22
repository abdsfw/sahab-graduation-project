class PaymentMethod {
  int? id;
  String? paymentMethod;
  String? photo;
  num? paymentMethodId;
  num? serviceCharge;
  DateTime? createdAt;

  PaymentMethod({
    this.id,
    this.paymentMethod,
    this.photo,
    this.paymentMethodId,
    this.serviceCharge,
    this.createdAt,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json['id'] as int?,
        paymentMethod: json['payment_method'] as String?,
        photo: json['photo'] as String?,
        paymentMethodId: json['payment_method_id'] as num?,
        serviceCharge: json['service_charge'] as num?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'payment_method': paymentMethod,
        'photo': photo,
        'payment_method_id': paymentMethodId,
        'service_charge': serviceCharge,
        'created_at': createdAt?.toIso8601String(),
      };
}
