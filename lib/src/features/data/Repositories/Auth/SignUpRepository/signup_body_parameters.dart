class SignUpBodyParameters {
  SignUpBodyParameters({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.departmentId,
    required this.municipalityId,
    required this.roles,
    required this.isActive,
    required this.password,
  });

  final String fullName;
  final String email;
  final String phone;
  final int departmentId;
  final int municipalityId;
  final List<String> roles;
  final bool isActive;
  final String password;

  Map<String, dynamic> toMap() => {
    "email": email,
    "phone_number": phone,
    "full_name": fullName,
    "department_id": departmentId,
    "municipality_id": municipalityId,
    "roles": roles,
    "is_active": isActive,
    "password": password,
  };
}
