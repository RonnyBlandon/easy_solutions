import 'package:easy_solutions/src/base/ApiService/app_error.dart';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Address/address_entity.dart';
import 'package:easy_solutions/src/features/data/Repositories/Address/address_repository.dart';

abstract class AddressUseCase {
  Future<AddressListEntity> getDeliveryAddressList();
  Future<AddressEntity> addDeliveryAddress({
    required AddressEntity deliveryAddress,
  });
  Future<AddressEntity> updateDeliveryAddress({
    required AddressEntity deliveryAddress,
  });
  Future<bool> deleteDeliveryAddress({required int deliveryAddressId});
}

class DefaultAddressUseCase extends AddressUseCase {
  // * Dependencies
  final AddressRepository _repository;

  DefaultAddressUseCase({AddressRepository? repository})
    : _repository = repository ?? DefaultAddressRepository();

  @override
  Future<AddressListEntity> getDeliveryAddressList() {
    return _repository
        .getDeliveryAddressList()
        .then((response) {
          return AddressListEntity.fromMap(response.toMap());
        })
        .catchError((e) {
          throw Failure.fromMessage(
            message: AppFailureMessages.unExpectedErrorMessage,
          );
        });
  }

  @override
  Future<AddressEntity> addDeliveryAddress({
    required AddressEntity deliveryAddress,
  }) async {
    return await _repository
        .addDeliveryAddress(
          bodyParameters: deliveryAddress.getAddressBodyParameters(),
        )
        .then(
          (response) {
            return AddressEntity.fromMap(response.toMap());
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
  Future<AddressEntity> updateDeliveryAddress({
    required AddressEntity deliveryAddress,
  }) {
    return _repository
        .updateDeliveryAddress(
          bodyParameters: deliveryAddress.getAddressBodyParameters(),
        )
        .then(
          (response) {
            return AddressEntity.fromMap(response.toMap());
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
  Future<bool> deleteDeliveryAddress({required int deliveryAddressId}) async {
    return await _repository.deleteDeliveryAddress(
      deliveryAddressId: deliveryAddressId,
    );
  }
}
