import 'dart:convert';

class GoogleSignInUserEntity {
  final String? localId;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? startDate;
  final String? tokenType;
  final String? accessToken;
  final String? refreshToken;
  final String? roles;

  GoogleSignInUserEntity({
    required this.localId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.startDate,
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.roles,
  });

  factory GoogleSignInUserEntity.fromJson(String str) =>
      GoogleSignInUserEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoogleSignInUserEntity.fromMap(Map<String, dynamic> json) =>
      GoogleSignInUserEntity(
        localId: json["local_id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        startDate: json["start_date"],
        tokenType: json["token_type"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        roles: json["roles"],
      );

  Map<String, dynamic> toMap() => {
    "local_id": localId,
    "full_name": fullName,
    "email": email,
    "phone_number": phoneNumber,
    "start_date": startDate,
    "token_type": tokenType,
    "access_token": accessToken,
    "refresh_token": refreshToken,
    "roles": roles,
  };
}
