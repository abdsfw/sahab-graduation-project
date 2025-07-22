class User {
  String? name;
  String? email;
  String? phone;
  String? imagePath;

  User({this.name, this.email, this.phone, this.imagePath});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      "email": email,
      'phone': phone,
      "imagePath": imagePath
    };
  }
}
