class AmenityModel {
  int? id;
  String? title;
  String? icon;
  bool? selected;

  AmenityModel({this.id, this.title, this.icon, this.selected = false});

  factory AmenityModel.fromJson(Map<String, dynamic> json) => AmenityModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'icon': icon,
      };
}
