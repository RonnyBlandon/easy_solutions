import 'package:easy_solutions/src/managers/businessManager/Decodables/business_list_decodable.dart';

abstract class BusinessManager {
  Future<BusinessListDecodable> fetchBusinessList();
  Future<BusinessListDecodable> fetchNoveltyBusinessList();
  Future<BusinessListDecodable> fetchPopularBusinessList();
  Future<BusinessListDecodable> fetchBusinessListByCategory(
      {required int categoryId});
  Future<BusinessListDecodable> fetchBusinessListByQuery(
      {required String query});
  Future<BusinessListDecodable> fetchBusinessListByRecentSearches(
      {required List<String> businessIds});
}
