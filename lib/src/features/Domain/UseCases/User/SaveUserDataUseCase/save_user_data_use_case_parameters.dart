import 'package:easy_solutions/src/features/Domain/Entities/User/user_entity.dart';

class SaveUserDataUseCaseParameters {
  SaveUserDataUseCaseParameters(
      {this.localId,
      this.role,
      this.names,
      this.surnames,
      this.email,
      this.phone,
      this.startDate,
      this.idToken});

  String? localId;
  UserRole? role;
  String? names;
  String? surnames;
  String? email;
  String? phone;
  String? startDate;
  String? idToken;

  Map<String, dynamic> toMap() => {
        "localId": localId,
        "role": role,
        "names": names,
        "surnames": surnames,
        "email": email,
        "phone": phone,
        "startDate": startDate,
        "idToken": idToken
      };
}
