import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/data/Decodables/DeliveryAddress/delivery_address_decodable.dart';
import 'package:easy_solutions/src/features/data/Repositories/DeliveryAddress/BodyParameters/delivery_address_body_parameters.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';

abstract class DeliveryAddressRepository {
  Future<DeliveryAddressListDecodable> getDeliveryAddressList();
  Future<DeliveryAddressListDecodable> saveDeliveryAddressList({
    required DeliveryAddressListBodyParameters bodyParameters,
  });
}

class DefaultDeliveryAddressRepository extends DeliveryAddressRepository {
  final String _path = "deliveryAddressList/";

  // * Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;

  DefaultDeliveryAddressRepository({
    RealtimeDataBaseService? realtimeDataBaseService,
  }) : _realtimeDataBaseService =
           realtimeDataBaseService ?? DefaultRealtimeDataBaseService();

  @override
  Future<DeliveryAddressListDecodable> getDeliveryAddressList() async {
    try {
      final response = await _realtimeDataBaseService.getData(
        path: _path,
        requiresAuth: true,
      );
      return DeliveryAddressListDecodable.fromMap(response);
    } on Failure catch (f) {
      if (f.message == RealtimeDatabaseExceptions.httpException) {
        return DeliveryAddressListDecodable.getEmptyPaymentMethods();
      } else {
        return Future.error(
          Failure.fromMessage(
            message: AppFailureMessages.unExpectedErrorMessage,
          ),
        );
      }
    }
  }

  @override
  Future<DeliveryAddressListDecodable> saveDeliveryAddressList({
    required DeliveryAddressListBodyParameters bodyParameters,
  }) async {
    var path = _path;
    try {
      final result = await _realtimeDataBaseService.putData(
        bodyParameters: bodyParameters.toMap(),
        path: path,
        requiresAuth: true,
      );
      return DeliveryAddressListDecodable.fromMap(result);
    } on Failure catch (f) {
      return Future.error(f.error);
    }
  }
}
