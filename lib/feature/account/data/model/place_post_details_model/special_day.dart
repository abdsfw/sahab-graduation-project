class SpecialDay {
  int? id;
  String? title;
  num? price;
  String? startDate;
  String? endDate;
  int? placeId;

  SpecialDay({
    this.id,
    this.title,
    this.price,
    this.startDate,
    this.endDate,
    this.placeId,
  });

  factory SpecialDay.fromJson(Map<String, dynamic> json) => SpecialDay(
        id: json['id'] as int?,
        title: json['title'] as String?,
        price: json['price'] as num?,
        startDate: json['start_date'] as String?,
        endDate: json['end_date'] as String?,
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
