import 'dart:convert';

class SignInDecodable {
  String? localId;
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? role;

  SignInDecodable({
    this.localId,
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.role,
  });

  factory SignInDecodable.fromJson(String str) =>
      SignInDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignInDecodable.fromMap(Map<String, dynamic> json) => SignInDecodable(
        localId: json["local_id"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        tokenType: json["token_type"],
        role: json["role"],
      );

  Map<String, dynamic> toMap() => {
        "local_id": localId,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "token_type": tokenType,
        "role": role,
      };
}
