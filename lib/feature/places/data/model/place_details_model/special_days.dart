class SpecialDays {
  int? id;
  String? title;
  int? price;
  DateTime? startDate;
  DateTime? endDate;
  int? placeId;

  SpecialDays({
    this.id,
    this.title,
    this.price,
    this.startDate,
    this.endDate,
    this.placeId,
  });

  factory SpecialDays.fromJson(Map<String, dynamic> json) => SpecialDays(
        id: json['id'] as int?,
        title: json['title'] as String?,
        price: json['price'] as int?,
        startDate: json['start_date'] == null
            ? null
            : DateTime.parse(json['start_date'] as String),
        endDate: json['end_date'] == null
            ? null
            : DateTime.parse(json['end_date'] as String),
        // startDate: json['start_date'] as String?,
        // endDate: json['end_date'] as String?,
        placeId: json['place_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'start_date': startDate,
        'end_date': endDate,
        'place_id': placeId,
      };
}
