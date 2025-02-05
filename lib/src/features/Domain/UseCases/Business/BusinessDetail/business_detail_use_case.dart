import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Business/business_detail_repository.dart';

abstract class BusinessDetailUseCase {
  Future<BusinessDetailEntity> fetchBusinessDetailById(
      {required String businessId});
}

class DefaultBusinessDetailUseCase extends BusinessDetailUseCase {
  //Dependencias
  final BusinessDetailRepository _businessDetailRepository;

  DefaultBusinessDetailUseCase({BusinessDetailRepository? businessRepository})
      : _businessDetailRepository =
            businessRepository ?? DefaultBusinessDetailRepository();

  @override
  Future<BusinessDetailEntity> fetchBusinessDetailById(
      {required String businessId}) async {
    final decodable = await _businessDetailRepository.fetchBusinessDetailById(
        businessId: businessId);
    return BusinessDetailEntity.fromMap(decodable.toMap());
  }
}
