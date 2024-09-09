import 'package:easy_solutions/src/services/GoogleSignInService/Entities/google_user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInMapper {
  static GoogleSignInUserEntity mapUserCredential(
      UserCredential credential, String? idToken) {
    return GoogleSignInUserEntity(credential.user, idToken);
  }
}
