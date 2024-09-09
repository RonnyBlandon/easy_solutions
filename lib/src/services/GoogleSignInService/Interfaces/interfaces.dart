import '../Entities/google_user_entity.dart';

abstract class GoogleSignInService {
  Future<GoogleSignInUserEntity> signInWithGoogle();
  Future<bool> isUserInDatabase({required String uid});
}
