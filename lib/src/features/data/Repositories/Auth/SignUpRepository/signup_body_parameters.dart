class SignUpBodyParameters {
  SignUpBodyParameters(
      {required this.fullName,
      required this.email,
      required this.phone,
      required this.departmentId,
      required this.municipalityId,
      required this.role,
      required this.isActive,
      required this.password});

  final String fullName;
  final String email;
  final String phone;
  final int departmentId;
  final int municipalityId;
  final String role;
  final bool isActive;
  final String password;

  Map<String, dynamic> toMap() => {
        "email": email,
        "phone_number": phone,
        "full_name": fullName,
        "department_id": departmentId,
        "municipality_id": municipalityId,
        "role": role,
        "is_active": isActive,
        "password": password
      };
}
