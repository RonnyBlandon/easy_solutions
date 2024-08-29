import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';

class SaveUserDataUseCaseParameters {
  SaveUserDataUseCaseParameters(
      {this.localId,
      this.role,
      this.username,
      this.email,
      this.phone,
      this.startDate,
      this.idToken});

  String? localId;
  UserRole? role;
  String? username;
  String? email;
  String? phone;
  String? startDate;
  String? idToken;

  Map<String, dynamic> toMap() => {
        "localId": localId,
        "role": role,
        "username": username,
        "email": email,
        "phone": phone,
        "startDate": startDate,
        "idToken": idToken
      };
}
