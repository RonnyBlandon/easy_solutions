import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';

class SaveUserDataUseCaseParameters {
  SaveUserDataUseCaseParameters(
      {this.localId,
      this.role,
      this.fullName,
      this.email,
      this.phone,
      this.departmentId,
      this.municipalityId,
      this.startDate,
      this.accessToken});

  String? localId;
  UserRole? role;
  String? fullName;
  String? email;
  String? phone;
  int? departmentId;
  int? municipalityId;
  String? startDate;
  String? accessToken;

  Map<String, dynamic> toMap() => {
        "localId": localId,
        "role": role,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "departmentId": departmentId,
        "municipalityId": municipalityId,
        "startDate": startDate,
        "accessToken": accessToken,
      };
}
