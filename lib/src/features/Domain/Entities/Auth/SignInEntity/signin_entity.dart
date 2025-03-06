import 'dart:convert';

class SignInEntity {
  String? localId;
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? roles;

  SignInEntity({
    this.localId,
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.roles,
  });

  factory SignInEntity.fromJson(String str) =>
      SignInEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignInEntity.fromMap(Map<String, dynamic> json) => SignInEntity(
    localId: json["local_id"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    roles: json["roles"],
  );

  Map<String, dynamic> toMap() => {
    "local_id": localId,
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "roles": roles,
  };
}
