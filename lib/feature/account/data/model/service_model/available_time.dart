class AvailableTime {
  int? id;
  String? startingDate;
  String? endingDate;
  int? serviceId;

  AvailableTime({
    this.id,
    this.startingDate,
    this.endingDate,
    this.serviceId,
  });

  factory AvailableTime.fromJson(Map<String, dynamic> json) => AvailableTime(
        id: json['id'] as int?,
        startingDate: json['starting_date'] as String?,
        endingDate: json['ending_date'] as String?,
        serviceId: json['service_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'starting_date': startingDate,
        'ending_date': endingDate,
        'service_id': serviceId,
      };
}
