class CategoryModel {
  int? id;
  String? title;
  String? icon;
  String? type;

  CategoryModel({this.id, this.title, this.icon, this.type});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        icon: json['icon'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'icon': icon,
        'type': type,
      };
}
