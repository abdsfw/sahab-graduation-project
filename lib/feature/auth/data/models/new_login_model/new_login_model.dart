import 'message.dart';

class NewLoginModel {
  Message? message;
  String? token;

  NewLoginModel({this.message, this.token});

  factory NewLoginModel.fromJson(Map<String, dynamic> json) => NewLoginModel(
        message: json['message'] == null
            ? null
            : Message.fromJson(json['message'] as Map<String, dynamic>),
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'message': message?.toJson(),
        'token': token,
      };
}

class NewRegisterModel {
  Message? message;
  String? token;

  NewRegisterModel({this.message, this.token});

  factory NewRegisterModel.fromJson(Map<String, dynamic> json) =>
      NewRegisterModel(
        message: json['user'] == null
            ? null
            : Message.fromJson(json['user'] as Map<String, dynamic>),
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'user': message?.toJson(),
        'token': token,
      };
}
