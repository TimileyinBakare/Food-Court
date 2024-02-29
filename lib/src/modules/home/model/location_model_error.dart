// To parse this JSON data, do
import 'dart:convert';

UserError userErrorFromJson(String str) => UserError.fromJson(json.decode(str));

String userErrorToJson(UserError data) => json.encode(data.toJson());

class UserError {
  String? code;
  Object? message;

  UserError({
    this.code,
    this.message,
  });

  factory UserError.fromJson(Map<String, dynamic> json) => UserError(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}