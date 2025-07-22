import 'invoice_data.dart';

class AddBookingResponseModel {
  String? message;
  InvoiceData? invoiceData;

  AddBookingResponseModel({this.message, this.invoiceData});

  factory AddBookingResponseModel.fromJson(Map<String, dynamic> json) {
    return AddBookingResponseModel(
      message: json['message'] as String?,
      invoiceData: json['invoice_data'] == null
          ? null
          : InvoiceData.fromJson(json['invoice_data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'invoice_data': invoiceData?.toJson(),
      };
}
