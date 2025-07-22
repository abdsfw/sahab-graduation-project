class AreaModel {
  int? id;
  String? area;
  bool? selected;

  AreaModel({this.id, this.area, this.selected = false});

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        id: json['id'] as int?,
        area: json['area'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'area': area,
      };
}
