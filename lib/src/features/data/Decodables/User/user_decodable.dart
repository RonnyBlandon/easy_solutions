import 'dart:convert';

class UserDecodable {
  String? localId;
  String? roles;
  String? fullName;
  String? email;
  String? phone;
  String? startDate;
  String? accessToken;
  String? provider;

  UserDecodable({
    this.localId,
    this.roles,
    this.fullName,
    this.email,
    this.phone,
    this.startDate,
    this.accessToken,
    this.provider,
  });

  factory UserDecodable.fromJson(String str) =>
      UserDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDecodable.fromMap(Map<String, dynamic> json) => UserDecodable(
    localId: json["local_id"],
    roles: json["roles"],
    fullName: json["full_name"],
    email: json["email"],
    phone: json["phone_number"],
    startDate: json["start_date"],
    accessToken: json["access_token"],
    provider: json["provider"],
  );

  Map<String, dynamic> toMap() => {
    "local_id": localId,
    "roles": roles,
    "full_name": fullName,
    "email": email,
    "phone_number": phone,
    "start_date": startDate,
    "access_token": accessToken,
    "provider": provider,
  };
}
