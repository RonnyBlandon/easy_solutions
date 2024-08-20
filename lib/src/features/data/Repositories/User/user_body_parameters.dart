class UserBodyParameters {
  UserBodyParameters(
      {this.localId,
      this.role,
      this.names,
      this.surnames,
      this.email,
      this.phone,
      this.startDate,
      this.idToken});

  String? localId;
  String? role;
  String? names;
  String? surnames;
  String? email;
  String? phone;
  String? startDate;
  String? idToken;

  Map<String, dynamic> toMap() => {
        "localId": localId,
        "role": role,
        "names": names,
        "surnames": surnames,
        "email": email,
        "phone": phone,
        "startDate": startDate,
        "idToken": idToken
      };
}
