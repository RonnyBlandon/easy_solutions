import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/managers/businessManager/Decodables/business_list_decodable.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';

class DefaultBusinessDetailRepository extends BusinessDetailRepository {
  final String _path = "businesses/";

  //Dependencias
  final RealtimeDataBaseService _realtimeDatabaseService;

  DefaultBusinessDetailRepository({
    RealtimeDataBaseService? realtimeDatabaseService,
  }) : _realtimeDatabaseService =
           realtimeDatabaseService ?? DefaultRealtimeDataBaseService();

  @override
  Future<BusinessDetailDecodable> fetchBusinessDetailById({
    required String businessId,
  }) async {
    String path = _path + businessId;
    final response = await _realtimeDatabaseService.getData(
      path: path,
      requiresAuth: false,
    );
    return BusinessDetailDecodable.fromMap(response);
  }
}
