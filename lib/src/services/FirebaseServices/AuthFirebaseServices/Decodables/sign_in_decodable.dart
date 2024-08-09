import 'dart:convert';

class SingInDecodable {
  String? kind;
  String? localId;
  String? email;
  String? displayName;
  String? idToken;
  bool? registered;

  SingInDecodable({
    this.kind,
    this.localId,
    this.email,
    this.displayName,
    this.idToken,
    this.registered,
  });

  factory SingInDecodable.fromJson(String str) =>
      SingInDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingInDecodable.fromMap(Map<String, dynamic> json) => SingInDecodable(
        kind: json["kind"],
        localId: json["localId"],
        email: json["email"],
        displayName: json["displayName"],
        idToken: json["idToken"],
        registered: json["registered"],
      );

  Map<String, dynamic> toMap() => {
        "kind": kind,
        "localId": localId,
        "email": email,
        "displayName": displayName,
        "idToken": idToken,
        "registered": registered,
      };
}
