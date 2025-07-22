class LoginModel {
  final String phone;

  LoginModel({required this.phone});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'phone': phone, "code": "0000"};
  }
}
