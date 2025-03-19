import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/PaymentMethods/payment_methods_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/PaymentMethods/payment_methods_repository.dart';

abstract class PaymentMethodsUseCase {
  Future<PaymentMethodListEntity> getPaymentMethods();
  Future<PaymentMethodEntity> addPaymentMethod({
    required PaymentMethodEntity parameters,
  });
  Future<PaymentMethodEntity> updatePaymentMethod({
    required PaymentMethodEntity parameters,
  });
  Future<bool> deletePaymentMethod({required String paymentMethodId});
}

class DefaultPaymentMethodsUseCase extends PaymentMethodsUseCase {
  // * Dependencies
  final PaymentMethodsRepository _paymentMethodsRepository;

  DefaultPaymentMethodsUseCase({
    PaymentMethodsRepository? paymentMethodsRepository,
  }) : _paymentMethodsRepository =
           paymentMethodsRepository ?? DefaultPaymentMethodsRepository();

  @override
  Future<PaymentMethodListEntity> getPaymentMethods() async {
    return await _paymentMethodsRepository
        .getPaymentMethods()
        .then((response) {
          PaymentMethodListEntity paymentMethods =
              PaymentMethodListEntity.fromMap(response.toMap());
          return paymentMethods;
        })
        .catchError((e) {
          throw Failure.fromMessage(
            message: AppFailureMessages.unExpectedErrorMessage,
          );
        });
  }

  @override
  Future<PaymentMethodEntity> addPaymentMethod({
    required PaymentMethodEntity parameters,
  }) async {
    return await _paymentMethodsRepository
        .addPaymentMethod(
          bodyParameters: parameters.getPaymentMethodBodyParameters(),
        )
        .then(
          (response) {
            return PaymentMethodEntity.fromMap(response.toMap());
          },
          onError: (e) {
            return Future.error(
              Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage,
              ),
            );
          },
        );
  }

  @override
  Future<PaymentMethodEntity> updatePaymentMethod({
    required PaymentMethodEntity parameters,
  }) async {
    return await _paymentMethodsRepository
        .updatePaymentMethod(
          bodyParameters: parameters.getPaymentMethodBodyParameters(),
        )
        .then(
          (response) {
            return PaymentMethodEntity.fromMap(response.toMap());
          },
          onError: (e) {
            return Future.error(
              Failure.fromMessage(
                message: AppFailureMessages.unExpectedErrorMessage,
              ),
            );
          },
        );
  }

  @override
  Future<bool> deletePaymentMethod({required String paymentMethodId}) async {
    return await _paymentMethodsRepository.deletePaymentMethod(
      paymentMethodId: paymentMethodId,
    );
  }
}
