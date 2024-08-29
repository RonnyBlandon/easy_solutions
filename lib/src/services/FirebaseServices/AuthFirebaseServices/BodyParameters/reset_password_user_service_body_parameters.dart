import 'dart:convert';

class ResetPasswordBodyParameters {
  String requestType;
  String email;

  ResetPasswordBodyParameters({
    required this.requestType,
    required this.email,
  });

  factory ResetPasswordBodyParameters.fromJson(String str) =>
      ResetPasswordBodyParameters.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResetPasswordBodyParameters.fromMap(Map<String, dynamic> json) =>
      ResetPasswordBodyParameters(
        requestType: json["requestType"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "requestType": requestType,
        "email": email,
      };
}
