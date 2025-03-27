import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/data/Decodables/Address/address_decodable.dart';
import 'package:easy_solutions/src/features/data/Repositories/Address/BodyParameters/delivery_address_body_parameters.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';

abstract class AddressRepository {
  Future<AddressListDecodable> getDeliveryAddressList();
  Future<AddressDecodable> addDeliveryAddress({
    required AddressBodyParameters bodyParameters,
  });
  Future<AddressDecodable> updateDeliveryAddress({
    required AddressBodyParameters bodyParameters,
  });
  Future<bool> deleteDeliveryAddress({required int deliveryAddressId});
}

class DefaultAddressRepository extends AddressRepository {
  final String _path = "addresses/";

  // * Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;

  DefaultAddressRepository({RealtimeDataBaseService? realtimeDataBaseService})
    : _realtimeDataBaseService =
          realtimeDataBaseService ?? DefaultRealtimeDataBaseService();

  @override
  Future<AddressListDecodable> getDeliveryAddressList() async {
    try {
      final response = await _realtimeDataBaseService.getData(
        path: _path,
        requiresAuth: true,
      );
      return AddressListDecodable.fromMap(response);
    } on Failure catch (f) {
      if (f.message == RealtimeDatabaseExceptions.httpException) {
        return AddressListDecodable.getEmptyAddressList();
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
  Future<AddressDecodable> addDeliveryAddress({
    required AddressBodyParameters bodyParameters,
  }) async {
    var path = _path;

    try {
      print(
        "Esto tiene bodyParameters en addDeliveryAddress de address_repository: ${bodyParameters.toMap()}",
      );
      final result = await _realtimeDataBaseService.postData(
        bodyParameters: bodyParameters.toMap(),
        path: path,
        requiresAuth: true,
      );
      return AddressDecodable.fromMap(result);
    } on Failure catch (f) {
      return Future.error(f.error);
    }
  }

  @override
  Future<AddressDecodable> updateDeliveryAddress({
    required AddressBodyParameters bodyParameters,
  }) async {
    var path = _path;
    try {
      final result = await _realtimeDataBaseService.putData(
        bodyParameters: bodyParameters.toMap(),
        path: path,
        requiresAuth: true,
      );
      print(
        "Esto tiene result en updateDeliveryAddress de address_repository: $result",
      );
      return AddressDecodable.fromMap(result);
    } on Failure catch (f) {
      return Future.error(f.error);
    }
  }

  @override
  Future<bool> deleteDeliveryAddress({required int deliveryAddressId}) async {
    var path = _path + deliveryAddressId.toString();
    try {
      final response = await _realtimeDataBaseService.deleteData(
        path: path,
        requiresAuth: true,
      );
      if (response.containsKey("message") &&
          response["message"] == "Dirección de entrega eliminado") {
        return true;
      } else {
        return false;
      }
    } on Failure catch (f) {
      return Future.error(f.error);
    }
  }
}
