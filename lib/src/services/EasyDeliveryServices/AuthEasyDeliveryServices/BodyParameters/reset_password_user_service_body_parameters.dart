import 'dart:convert';

class ResetPasswordBodyParameters {
  String email;

  ResetPasswordBodyParameters({required this.email});

  factory ResetPasswordBodyParameters.fromJson(String str) =>
      ResetPasswordBodyParameters.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResetPasswordBodyParameters.fromMap(Map<String, dynamic> json) =>
      ResetPasswordBodyParameters(email: json["email"]);

  Map<String, dynamic> toMap() => {"email": email};
}
