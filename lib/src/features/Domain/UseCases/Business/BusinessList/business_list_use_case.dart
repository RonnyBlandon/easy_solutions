import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Business/business_list_repository.dart';

abstract class BusinessListUseCase {
  Future<TypeBusinessListEntity> fetchTypeBusinessList();
  Future<BusinessListEntity> fetchBusinessList();
  Future<BusinessListEntity> fetchNoveltyBusinessList();
  Future<BusinessListEntity> fetchPopularBusinessList();
  Future<BusinessListEntity> fetchBusinessListByTypeBusiness(
      {required int typeBusinessId});
  Future<BusinessListEntity> fetchBusinessListByQuery({required String query});
  Future<BusinessListEntity> fetchBusinessListByRecentSearches(
      {required List<String> businessIds});
}

class DefaultBusinessListUseCase extends BusinessListUseCase {
  //Dependencias
  final BusinessListRepository _businessListRepository;

  DefaultBusinessListUseCase({BusinessListRepository? businessListRepository})
      : _businessListRepository =
            businessListRepository ?? DefaultBusinessListRepository();

  @override
  Future<TypeBusinessListEntity> fetchTypeBusinessList() async {
    final typeBusinessListDecodable =
        await _businessListRepository.fetchTypeBusinessList();
    return TypeBusinessListEntity.fromMap(typeBusinessListDecodable.toMap());
  }

  @override
  Future<BusinessListEntity> fetchBusinessList() async {
    final businessListDecodable =
        await _businessListRepository.fetchBusinessList();
    return BusinessListEntity.fromMap(businessListDecodable.toMap());
  }

  @override
  Future<BusinessListEntity> fetchBusinessListByTypeBusiness(
      {required int typeBusinessId}) async {
    final businessListDecodable = await _businessListRepository
        .fetchBusinessListByTypeBusiness(typeBusinessId: typeBusinessId);
    return BusinessListEntity.fromMap(businessListDecodable.toMap());
  }

  @override
  Future<BusinessListEntity> fetchBusinessListByQuery(
      {required String query}) async {
    final businessListDecodable =
        await _businessListRepository.fetchBusinessListByQuery(query: query);
    return BusinessListEntity.fromMap(businessListDecodable.toMap());
  }

  @override
  Future<BusinessListEntity> fetchBusinessListByRecentSearches(
      {required List<String> businessIds}) async {
    final businessListDecodable = await _businessListRepository
        .fetchBusinessListByRecentSearches(businessIds: businessIds);
    return BusinessListEntity.fromMap(businessListDecodable.toMap());
  }

  @override
  Future<BusinessListEntity> fetchNoveltyBusinessList() async {
    final businessListDecodable =
        await _businessListRepository.fetchNoveltyBusinessList();
    return BusinessListEntity.fromMap(businessListDecodable.toMap());
  }

  @override
  Future<BusinessListEntity> fetchPopularBusinessList() async {
    final businessListDecodable =
        await _businessListRepository.fetchPopularBusinessList();
    return BusinessListEntity.fromMap(businessListDecodable.toMap());
  }
}
