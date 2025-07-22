class StaticContentModel {
  int? id;
  String? title;
  String? description;
  String? content;

  StaticContentModel({this.id, this.title, this.description, this.content});

  factory StaticContentModel.fromJson(Map<String, dynamic> json) {
    return StaticContentModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'content': content,
      };
}
