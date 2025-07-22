class User {
  final String userName;
  final String email;
  final String phone;
  User({required this.userName, required this.email, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userName: json['name'], email: json['email'], phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {'name': userName, 'email': email, 'phone': phone};
  }
}
