import 'dart:convert';

class UserEntity {
  String? localId;
  String? role;
  String? username;
  String? email;
  String? phone;
  String? startDate;
  String? idToken;

  UserEntity({
    this.localId,
    this.role,
    this.username,
    this.email,
    this.phone,
    this.startDate,
    this.idToken,
  });

  factory UserEntity.fromJson(String str) =>
      UserEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
        localId: json["localId"],
        role: json["role"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        startDate: json["startDate"],
        idToken: json["idToken"],
      );

  Map<String, dynamic> toMap() => {
        "localId": localId,
        "role": role,
        "username": username,
        "email": email,
        "phone": phone,
        "startDate": startDate,
        "idToken": idToken,
      };
}

enum UserRole { user, owner, admin, rider }

extension ParseToString on UserRole {
  String toShortString() {
    return toString().split('.').last;
  }
}
