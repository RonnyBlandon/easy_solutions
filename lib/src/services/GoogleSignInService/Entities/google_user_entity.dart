import 'dart:convert';

class GoogleSignInUserEntity {
  final String? localId;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? startDate;
  final String? role;
  final String? accessToken;
  final String? refreshToken;

  GoogleSignInUserEntity({
    required this.localId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.startDate,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });

  factory GoogleSignInUserEntity.fromJson(String str) =>
      GoogleSignInUserEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoogleSignInUserEntity.fromMap(Map<String, dynamic> json) =>
      GoogleSignInUserEntity(
        localId: json["localId"],
        fullName: json["fullName"],
        email: json["email"],
        phone: json["phone"],
        startDate: json["startDate"],
        role: json["role"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toMap() => {
        "localId": localId,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "startDate": startDate,
        "role": role,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
