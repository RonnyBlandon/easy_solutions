class UserBodyParameters {
  UserBodyParameters(
      {this.localId,
      this.role,
      this.username,
      this.email,
      this.phone,
      this.startDate,
      this.idToken});

  String? localId;
  String? role;
  String? username;
  String? email;
  String? phone;
  String? startDate;
  String? idToken;

  Map<String, dynamic> toMap() => {
        "localId": localId,
        "role": role,
        "username": username,
        "email": email,
        "phone": phone,
        "startDate": startDate,
        "idToken": idToken
      };
}
