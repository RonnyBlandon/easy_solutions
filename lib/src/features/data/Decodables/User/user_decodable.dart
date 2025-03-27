import 'dart:convert';

class UserDecodable {
  String? localId;
  List<String>? roles;
  String? fullName;
  String? email;
  String? phone;
  String? startDate;
  int? municipalityId;
  String? accessToken;
  List<String>? providers;

  UserDecodable({
    this.localId,
    this.roles,
    this.fullName,
    this.email,
    this.phone,
    this.startDate,
    this.municipalityId,
    this.accessToken,
    this.providers,
  });

  factory UserDecodable.fromJson(String str) =>
      UserDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDecodable.fromMap(Map<String, dynamic> json) => UserDecodable(
    localId: json["local_id"],
    roles: List<String>.from(json['roles'] ?? []),
    fullName: json["full_name"],
    email: json["email"],
    phone: json["phone_number"],
    startDate: json["start_date"],
    municipalityId: json["municipality_id"],
    accessToken: json["access_token"],
    providers: List<String>.from(json['providers'] ?? []),
  );

  Map<String, dynamic> toMap() => {
    "local_id": localId,
    "roles": roles,
    "full_name": fullName,
    "email": email,
    "phone_number": phone,
    "start_date": startDate,
    "municiaplity_id": municipalityId,
    "access_token": accessToken,
    "providers": providers,
  };
}
