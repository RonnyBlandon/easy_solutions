import 'package:easy_solutions/src/features/data/Decodables/ProductDecodable/products_decodable.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';

class DefaultProductRepository extends ProductRepository {
  final String _path = "products";
  //Dependencias
  final RealtimeDatabaseService _realtimeDatabaseService;

  DefaultProductRepository({RealtimeDatabaseService? realtimeDatabaseService})
      : _realtimeDatabaseService =
            realtimeDatabaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<ProductListDecodable> fetchProductListByRecentSearches(
      {required List<String> productIds}) async {
    String path = "$_path/search_by_ids/";
    final response = await _realtimeDatabaseService
        .postData(path: path, bodyParameters: {"product_ids": productIds});
    ProductListDecodable decodable = ProductListDecodable.fromMap(response);
    return decodable;
  }

  @override
  Future<ProductListDecodable> fetchProductListByQuery(
      {required String businessId, required String query}) async {
    String path = "$_path/search?business_id=$businessId&query=$query";
    final response = await _realtimeDatabaseService.getData(path: path);
    ProductListDecodable decodable = ProductListDecodable.fromMap(response);
    return decodable;
  }
}
