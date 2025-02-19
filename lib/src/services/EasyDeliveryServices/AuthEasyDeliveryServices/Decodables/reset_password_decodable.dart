import 'dart:convert';

class ResetPasswordDecodable {
  String? kind;
  String? email;

  ResetPasswordDecodable({
    this.kind,
    this.email,
  });

  factory ResetPasswordDecodable.fromJson(String str) =>
      ResetPasswordDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResetPasswordDecodable.fromMap(Map<String, dynamic> json) =>
      ResetPasswordDecodable(
        kind: json["kind"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "kind": kind,
        "email": email,
      };
}
