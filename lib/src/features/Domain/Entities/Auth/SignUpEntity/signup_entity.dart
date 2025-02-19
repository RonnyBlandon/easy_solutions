import 'dart:convert';

class SignUpEntity {
  String? localId;
  String? tokenType;
  String? accessToken;
  String? refreshToken;

  SignUpEntity({
    this.localId,
    this.tokenType,
    this.accessToken,
    this.refreshToken,
  });

  factory SignUpEntity.fromJson(String str) =>
      SignUpEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignUpEntity.fromMap(Map<String, dynamic> json) => SignUpEntity(
      tokenType: json["token_type"],
      localId: json["local_id"],
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"]);

  Map<String, dynamic> toMap() => {
        "tokenType": tokenType,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "localId": localId
      };
}
