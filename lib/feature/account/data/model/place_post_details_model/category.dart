class Category {
  int? id;
  String? title;
  String? titleAr;
  String? icon;
  int? status;
  String? type;

  Category({
    this.id,
    this.title,
    this.titleAr,
    this.icon,
    this.status,
    this.type,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int?,
        title: json['title'] as String?,
        titleAr: json['title_ar'] as String?,
        icon: json['icon'] as String?,
        status: json['status'] as int?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'title_ar': titleAr,
        'icon': icon,
        'status': status,
        'type': type,
      };
}
