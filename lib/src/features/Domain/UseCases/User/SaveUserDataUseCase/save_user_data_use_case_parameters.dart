import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';

class SaveUserDataUseCaseParameters {
  SaveUserDataUseCaseParameters({
    this.localId,
    this.roles,
    this.fullName,
    this.email,
    this.phone,
    this.departmentId,
    this.municipalityId,
    this.startDate,
    this.accessToken,
    this.providers,
  });

  String? localId;
  List<String>? roles;
  String? fullName;
  String? email;
  String? phone;
  int? departmentId;
  int? municipalityId;
  String? startDate;
  String? accessToken;
  List<String>? providers;

  SaveUserDataUseCaseParameters.fromUserEntity(UserEntity user) {
    localId = user.localId;
    roles = user.roles;
    fullName = user.fullName;
    email = user.email;
    phone = user.phone;
    startDate = user.startDate;
    accessToken = user.accessToken;
    providers = user.providers;
  }

  Map<String, dynamic> toMap() => {
    "local_id": localId,
    "roles": roles,
    "full_name": fullName,
    "email": email,
    "phone_number": phone,
    "department_id": departmentId,
    "municipality_id": municipalityId,
    "start_date": startDate,
    "access_token": accessToken,
    "providers": providers,
  };
}
