import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/managers/businessManager/Decodables/business_list_decodable.dart';
import 'package:easy_solutions/src/managers/businessManager/Interfaces/business_manager_interfaces.dart';
import 'package:easy_solutions/src/managers/businessManager/business_manager.dart';

class DefaultBusinessListRepository extends BusinessListRepository {
  // * Dependencies
  final BusinessManager _businessManager;

  DefaultBusinessListRepository({BusinessManager? businessManager})
      : _businessManager = businessManager ?? DefaultBusinessManager();

  @override
  Future<BusinessListDecodable> fetchBusinessList() {
    return _businessManager.fetchBusinessList();
  }

  @override
  Future<BusinessListDecodable> fetchBusinessListByTypeBusiness(
      {required int typeBusinessId}) {
    return _businessManager.fetchBusinessListByTypeBusiness(
        typeBusinessId: typeBusinessId);
  }

  @override
  Future<BusinessListDecodable> fetchBusinessListByQuery(
      {required String query}) {
    return _businessManager.fetchBusinessListByQuery(query: query);
  }

  @override
  Future<BusinessListDecodable> fetchBusinessListByRecentSearches(
      {required List<String> businessIds}) {
    return _businessManager.fetchBusinessListByRecentSearches(
        businessIds: businessIds);
  }

  @override
  Future<BusinessListDecodable> fetchNoveltyBusinessList() {
    return _businessManager.fetchNoveltyBusinessList();
  }

  @override
  Future<BusinessListDecodable> fetchPopularBusinessList() {
    return _businessManager.fetchPopularBusinessList();
  }

  @override
  Future<TypeBusinessListDecodable> fetchTypeBusinessList() {
    return _businessManager.fetchTypeBusinessList();
  }
}
