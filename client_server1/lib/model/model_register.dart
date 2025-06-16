import 'dart:convert';

ModelRegister modelRegisterFromJson(String str) =>
    ModelRegister.fromJson(json.decode(str));

String modelRegisterToJson(ModelRegister data) =>
    json.encode(data.toJson());

class ModelRegister {
  final int value;
  final String message;

  ModelRegister({
    required this.value,
    required this.message,
  });

  factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
