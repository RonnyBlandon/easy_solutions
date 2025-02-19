import 'dart:convert';

class SignInDecodable {
  String? kind;
  String? localId;
  String? email;
  String? displayName;
  String? idToken;
  bool? registered;

  SignInDecodable({
    this.kind,
    this.localId,
    this.email,
    this.displayName,
    this.idToken,
    this.registered,
  });

  factory SignInDecodable.fromJson(String str) =>
      SignInDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SignInDecodable.fromMap(Map<String, dynamic> json) => SignInDecodable(
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
