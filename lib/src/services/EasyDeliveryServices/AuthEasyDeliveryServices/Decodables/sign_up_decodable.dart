import 'dart:convert';

class SignUpDecodable {
  String? localId;
  String? tokenType;
  String? accessToken;
  String? refreshToken;

  SignUpDecodable(
      {this.localId, this.tokenType, this.accessToken, this.refreshToken});

  factory SignUpDecodable.fromJson(String str) =>
      SignUpDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignUpDecodable.fromMap(Map<String, dynamic> json) => SignUpDecodable(
      tokenType: json["token_type"],
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      localId: json["local_id"]);

  Map<String, dynamic> toMap() => {
        "token_type": tokenType,
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "local_id": localId,
      };
}
