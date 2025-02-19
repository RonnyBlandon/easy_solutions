import 'dart:convert';

class UserDecodable {
  String? localId;
  String? role;
  String? username;
  String? email;
  String? phone;
  String? startDate;
  String? accessToken;

  UserDecodable({
    this.localId,
    this.role,
    this.username,
    this.email,
    this.phone,
    this.startDate,
    this.accessToken,
  });

  factory UserDecodable.fromJson(String str) =>
      UserDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDecodable.fromMap(Map<String, dynamic> json) => UserDecodable(
        localId: json["localId"],
        role: json["role"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        startDate: json["startDate"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toMap() => {
        "localId": localId,
        "role": role,
        "username": username,
        "email": email,
        "phone": phone,
        "startDate": startDate,
        "accessToken": accessToken,
      };
}
