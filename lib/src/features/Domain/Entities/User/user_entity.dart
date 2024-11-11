import 'dart:convert';

class UserEntity {
  String? localId;
  String? role;
  String? fullName;
  String? email;
  String? phone;
  String? startDate;
  String? accessToken;

  UserEntity({
    this.localId,
    this.role,
    this.fullName,
    this.email,
    this.phone,
    this.startDate,
    this.accessToken,
  });

  factory UserEntity.fromJson(String str) =>
      UserEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
        localId: json["localId"],
        role: json["role"],
        fullName: json["fullName"],
        email: json["email"],
        phone: json["phone"],
        startDate: json["startDate"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toMap() => {
        "localId": localId,
        "role": role,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "startDate": startDate,
        "accessToken": accessToken,
      };
}

enum UserRole { user, owner, admin, rider }

extension ParseToString on UserRole {
  String toShortString() {
    return toString().split('.').last;
  }
}
