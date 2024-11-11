class SignUpModel {
  SignUpModel(
      {this.username,
      this.email,
      this.phone,
      this.departmentId,
      this.municipalityId,
      this.password,
      this.repeatPassword});

  String? username;
  String? email;
  String? phone;
  int? departmentId;
  int? municipalityId;
  String? password;
  String? repeatPassword;
}
