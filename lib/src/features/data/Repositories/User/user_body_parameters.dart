class UserBodyParameters {
  UserBodyParameters({
    this.localId,
    this.roles,
    this.fullName,
    this.email,
    this.phone,
    this.startDate,
    this.accessToken,
  });

  String? localId;
  String? roles;
  String? fullName;
  String? email;
  String? phone;
  String? startDate;
  String? accessToken;

  Map<String, dynamic> toMap() => {
    "local_id": localId,
    "roles": roles,
    "full_name": fullName,
    "email": email,
    "phone_number": phone,
    "start_date": startDate,
    "access_token": accessToken,
  };
}
