class SkipModel {
  int? id;
  String? image;

  SkipModel({this.id, this.image});

  factory SkipModel.fromJson(Map<String, dynamic> json) => SkipModel(
        id: json['id'] as int?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
      };
}
