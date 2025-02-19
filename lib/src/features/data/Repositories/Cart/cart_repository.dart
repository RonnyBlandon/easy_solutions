import 'package:easy_solutions/src/features/data/Decodables/CartDecodable/cart_decodable.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';

class DefaultCartRepository extends CartRepository {
  final String _path = "carts";
  //Dependencias
  final RealtimeDatabaseService _realtimeDatabaseService;

  DefaultCartRepository({RealtimeDatabaseService? realtimeDatabaseService})
      : _realtimeDatabaseService =
            realtimeDatabaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<CartsListDecodable> fetchCartsList({required String userId}) async {
    String path = "$_path/restaurant/$userId/";
    final response = await _realtimeDatabaseService.getData(path: path);
    CartsListDecodable decodable = CartsListDecodable.fromMap(response);
    return decodable;
  }
}
