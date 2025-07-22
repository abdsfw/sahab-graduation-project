class InvoiceData {
  String? invoiceUrl;
  num? invoiceId;

  InvoiceData({this.invoiceUrl, this.invoiceId});

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        invoiceUrl: json['invoiceURL'] as String?,
        invoiceId: json['invoiceId'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'invoiceURL': invoiceUrl,
        'invoiceId': invoiceId,
      };
}
