import 'package:easy_solutions/src/features/data/Decodables/CategoriesDecodable/categories_decodable.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';

class DefaultCategoriesRepository extends CategoriesRepository {
  final String _path = "categories";

  //Dependencias
  final RealtimeDatabaseService _realtimeDatabaseService;

  DefaultCategoriesRepository(
      {RealtimeDatabaseService? realtimeDatabaseService})
      : _realtimeDatabaseService =
            realtimeDatabaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<BusinessCategoryListDecodable> fetchCategories(
      {required String businessId}) async {
    String path = "$_path/$businessId/";
    final response = await _realtimeDatabaseService.getData(path: path);
    BusinessCategoryListDecodable decodable =
        BusinessCategoryListDecodable.fromMap(response);
    return decodable;
  }
}
