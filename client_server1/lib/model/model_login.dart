import 'dart:convert';

ModelLogin modelLoginFromJson(String str) =>
    ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) =>
    json.encode(data.toJson());

class ModelLogin {
  final int value;
  final String message;
  final String username;
  final String fullname;
  final String id;

  ModelLogin({
    required this.value,
    required this.message,
    required this.username,
    required this.fullname,
    required this.id,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    value: json["value"],
    message: json["message"],
    username: json["username"] ?? '',
    fullname: json["fullname"] ?? '',
    id: json["id"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "username": username,
    "fullname": fullname,
    "id": id,
  };
}
