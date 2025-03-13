class SignUpUseCaseParameters {
  final String fullName;
  final String email;
  final String phone;
  final int departmentId;
  final int municipalityId;
  final List<String> roles;
  final bool isActive;
  final String password;

  SignUpUseCaseParameters({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.departmentId,
    required this.municipalityId,
    required this.roles,
    required this.isActive,
    required this.password,
  });
}
