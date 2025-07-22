import 'pivot.dart';

class Amenity {
  int? id;
  String? title;
  String? icon;
  Pivot? pivot;

  Amenity({this.id, this.title, this.icon, this.pivot});

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        id: json['id'] as int?,
        title: json['title'] as String?,
        icon: json['icon'] as String?,
        pivot: json['pivot'] == null
            ? null
            : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'icon': icon,
        'pivot': pivot?.toJson(),
      };
}
