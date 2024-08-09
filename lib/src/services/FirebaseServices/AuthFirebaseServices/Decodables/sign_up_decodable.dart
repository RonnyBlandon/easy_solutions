import 'dart:convert';

class SingUpDecodable {
  String? kind;
  String? idToken;
  String? email;
  String? refreshToken;
  String? expiresIn;
  String? localId;

  SingUpDecodable({
    this.kind,
    this.idToken,
    this.email,
    this.refreshToken,
    this.expiresIn,
    this.localId,
  });

  factory SingUpDecodable.fromJson(String str) =>
      SingUpDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingUpDecodable.fromMap(Map<String, dynamic> json) => SingUpDecodable(
        kind: json["kind"],
        idToken: json["idToken"],
        email: json["email"],
        refreshToken: json["refreshToken"],
        expiresIn: json["expiresIn"],
        localId: json["localId"],
      );

  Map<String, dynamic> toMap() => {
        "kind": kind,
        "idToken": idToken,
        "email": email,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "localId": localId,
      };
}
