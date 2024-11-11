class SignUpUseCaseParameters {
  final String fullName;
  final String email;
  final String phone;
  final int departmentId;
  final int municipalityId;
  final String role;
  final bool isActive;
  final String password;

  SignUpUseCaseParameters(
      {required this.fullName,
      required this.email,
      required this.phone,
      required this.departmentId,
      required this.municipalityId,
      required this.role,
      required this.isActive,
      required this.password});
}
