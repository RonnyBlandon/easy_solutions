import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/services/FirebaseServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/FirebaseServices/RealtimeDatabaseService/Services/realtime_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Entities/google_user_entity.dart';
import '../Interfaces/interfaces.dart';
import '../Mappers/google_sign_in_mapper.dart';

class DefaultGoogleSignInService extends GoogleSignInService {
  final String _path = "users/";

  // Dependencias
  final RealtimeDatabaseService _realtimeDatabaseService;

  DefaultGoogleSignInService({RealtimeDatabaseService? realtimeDatabaseService})
      : _realtimeDatabaseService =
            realtimeDatabaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<bool> isUserInDatabase({required String uid}) async {
    final fullpath = _path + uid;

    try {
      final result = await _realtimeDatabaseService.getData(path: fullpath);
      return result.isNotEmpty;
    } on Failure {
      return false;
    }
  }

  @override
  Future<GoogleSignInUserEntity> signInWithGoogle() async {
    // Sign out of the old Google account, if applicable
    await GoogleSignIn().signOut();

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return GoogleSignInMapper.mapUserCredential(
        userCredential, await userCredential.user?.getIdToken() ?? "");
  }
}
