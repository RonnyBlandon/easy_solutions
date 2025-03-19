import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/data/Decodables/PaymentMethods/payment_methods_decodable.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/PaymentMethods/BodyParameters/payment_methods_body_parameters.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';

class DefaultPaymentMethodsRepository extends PaymentMethodsRepository {
  final String _path = "payment_methods/";

  // * Dependencies
  final RealtimeDataBaseService _realtimeDataBaseService;

  DefaultPaymentMethodsRepository({
    RealtimeDataBaseService? realtimeDataBaseService,
  }) : _realtimeDataBaseService =
           realtimeDataBaseService ?? DefaultRealtimeDataBaseService();

  @override
  Future<PaymentMethodListDecodable> getPaymentMethods() async {
    try {
      final response = await _realtimeDataBaseService.getData(
        path: _path,
        requiresAuth: true,
      );
      PaymentMethodListDecodable paymentMethodsDecodable =
          PaymentMethodListDecodable.fromMap(response);
      return paymentMethodsDecodable;
    } on Failure catch (f) {
      if (f.message == RealtimeDatabaseExceptions.httpException) {
        return PaymentMethodListDecodable.getEmptyPaymentMethods();
      } else {
        throw Failure.fromMessage(
          message: AppFailureMessages.unExpectedErrorMessage,
        );
      }
    }
  }

  @override
  Future<PaymentMethodDecodable> addPaymentMethod({
    required PaymentMethodBodyParameters bodyParameters,
  }) async {
    var path = _path;

    try {
      final result = await _realtimeDataBaseService.postData(
        bodyParameters: bodyParameters.toMap(),
        path: path,
        requiresAuth: true,
      );
      return PaymentMethodDecodable.fromMap(result);
    } on Failure catch (f) {
      return Future.error(f.error);
    }
  }

  @override
  Future<PaymentMethodDecodable> updatePaymentMethod({
    required PaymentMethodBodyParameters bodyParameters,
  }) async {
    var path = _path;
    try {
      final result = await _realtimeDataBaseService.putData(
        bodyParameters: bodyParameters.toMap(),
        path: path,
        requiresAuth: true,
      );
      return PaymentMethodDecodable.fromMap(result);
    } on Failure catch (f) {
      return Future.error(f.error);
    }
  }

  @override
  Future<bool> deletePaymentMethod({required String paymentMethodId}) async {
    var path = _path + paymentMethodId;
    try {
      final response = await _realtimeDataBaseService.deleteData(
        path: path,
        requiresAuth: true,
      );
      if (response.containsKey("message") &&
          response["message"] == "Método de pago eliminado") {
        return true;
      } else {
        return false;
      }
    } on Failure catch (f) {
      return Future.error(f.error);
    }
  }
}
