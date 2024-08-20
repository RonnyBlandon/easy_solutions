class SignUpUseCaseParameters {
  final String names;
  final String surnames;
  final String email;
  final String phone;
  final String password;
  final String repeatPassword;

  SignUpUseCaseParameters(
      {required this.names,
      required this.surnames,
      required this.email,
      required this.phone,
      required this.password,
      required this.repeatPassword});
}
