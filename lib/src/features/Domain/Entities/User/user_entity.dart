import 'dart:convert';

class UserEntity {
  String? localId;
  List<String>? roles;
  String? fullName;
  String? email;
  String? phone;
  String? startDate;
  String? accessToken;
  List<String>? providers;

  UserEntity({
    this.localId,
    this.roles,
    this.fullName,
    this.email,
    this.phone,
    this.startDate,
    this.accessToken,
    this.providers,
  });

  UserEntity copyWith({
    String? localId,
    List<String>? roles,
    String? fullName,
    String? email,
    String? phone,
    String? startDate,
    String? accessToken,
    List<String>? providers,
  }) {
    return UserEntity(
      localId: localId,
      roles: roles,
      fullName: fullName,
      email: email,
      phone: phone,
      startDate: startDate,
      accessToken: accessToken,
      providers: providers,
    );
  }

  factory UserEntity.fromJson(String str) =>
      UserEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
    localId: json["local_id"],
    roles: json["roles"],
    fullName: json["full_name"],
    email: json["email"],
    phone: json["phone_number"],
    startDate: json["start_date"],
    accessToken: json["access_token"],
    providers: json["providers"],
  );

  Map<String, dynamic> toMap() => {
    "local_id": localId,
    "roles": roles,
    "full_name": fullName,
    "email": email,
    "phone_number": phone,
    "start_date": startDate,
    "access_token": accessToken,
    "providers": providers,
  };
}

class UserAuthProvider {
  static String google = "GOOGLE";
  static String email = "EMAIL";
}
