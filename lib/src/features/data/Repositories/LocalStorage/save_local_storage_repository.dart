import 'package:easy_solutions/src/features/Domain/Interfaces/Interfaces.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefaultSaveLocalStorageRepository extends SaveLocalStorageRepository {
  // * Dependencias
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> saveInLocalStorage(
      {required String key, required String value}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }
}
