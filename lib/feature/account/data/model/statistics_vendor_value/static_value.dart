class StaticValue {
  int? day;
  int? month;
  int? upcoming;
  int? count;

  StaticValue({this.day, this.month, this.upcoming, this.count});

  factory StaticValue.fromJson(Map<String, dynamic> json) {
    return StaticValue(
      day: json['day'] != null ? json['day'] as int : null,
      month: json['month'] != null ? json['month'] as int : null,
      upcoming: json['upcoming'] != null ? json['upcoming'] as int : null,
      count: json['count'] != null ? json['count'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['month'] = this.month;
    data['upcoming'] = this.upcoming;
    data['count'] = this.count;
    return data;
  }
}
