class SignUpUseCaseParameters {
  final String username;
  final String email;
  final String phone;
  final String password;
  final String repeatPassword;

  SignUpUseCaseParameters(
      {required this.username,
      required this.email,
      required this.phone,
      required this.password,
      required this.repeatPassword});
}
