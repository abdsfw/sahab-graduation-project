class StaticVendorValue {
  num? day;
  num? month;
  num? upcoming;
  num? count;

  StaticVendorValue({
    this.day,
    this.month,
    this.upcoming,
    this.count,
  });

  factory StaticVendorValue.fromJson(Map<String, dynamic>? json) {
    return StaticVendorValue(
      day: json?['day'] ?? 0,
      month: json?['month'] ?? 0,
      upcoming: json?['upcoming'] ?? 0,
      count: json?['count'] ?? 0,
    );
  }
}
