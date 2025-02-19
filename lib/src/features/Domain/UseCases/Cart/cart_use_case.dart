import 'package:easy_solutions/src/features/Domain/Entities/Cart/cart_entity.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/features/data/Repositories/Cart/cart_repository.dart';

abstract class CartsUseCase {
  Future<CartsListEntity> fetchCartsListUseCase({required String userId});
}

class DefaultCartUseCase extends CartsUseCase {
  //Dependencias
  final CartRepository _cartRepository;

  DefaultCartUseCase({CartRepository? cartRepository})
      : _cartRepository = cartRepository ?? DefaultCartRepository();

  @override
  Future<CartsListEntity> fetchCartsListUseCase(
      {required String userId}) async {
    final decodable = await _cartRepository.fetchCartsList(userId: userId);
    return CartsListEntity.fromMap(decodable.toMap());
  }
}
