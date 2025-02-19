import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefaultRemoveLocalStorageRepository extends RemoveLocalStorageRepository {
  // * Dependencias
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> removeLocalStorage({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }
}
