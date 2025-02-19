import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefaultFetchLocalStorageRepository extends FetchLocalStorageRepository {
  // * Dependencias
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<String?> fetchInLocalStorage({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  @override
  Future<List<String>?> fetchRecentProductSearches({required String businessId}) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList(businessId);
  }
}
