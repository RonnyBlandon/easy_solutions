import 'package:easy_solutions/src/features/data/Decodables/ProductDecodable/products_decodable.dart';
import 'package:easy_solutions/src/features/data/Interfaces/interfaces.dart';
import 'package:easy_solutions/src/managers/businessManager/Decodables/business_list_decodable.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Interfaces/interface.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/RealtimeDatabaseService/Services/realtime_database_service.dart';

class DefaultFavoriteRepository extends FavoriteRepository {
  final String _pathBusinessCreateFavorite = "favourites/business/";
  final String _pathProductCreateFavorite = "favourites/product/";
  final String _pathBusinessGetFavorites = "favourites/businesses";
  final String _pathProductGetFavorites = "favourites/products";
  final String _pathBusinessDeleteFavorite = "favourites/business/";
  final String _pathProductDeleteFavorite = "favourites/product/";
  //Dependencias
  final RealtimeDatabaseService _realtimeDatabaseService;

  DefaultFavoriteRepository({RealtimeDatabaseService? realtimeDatabaseService})
    : _realtimeDatabaseService =
          realtimeDatabaseService ?? DefaultRealtimeDatabaseService();

  @override
  Future<BusinessListDecodable> fetchBuisnessFavoritesList() async {
    final response = await _realtimeDatabaseService.getData(
      path: _pathBusinessGetFavorites,
      requiresAuth: true,
    );
    BusinessListDecodable decodable = BusinessListDecodable.fromMap(response);
    return decodable;
  }

  @override
  Future<ProductListDecodable> fetchProductFavoritesList() async {
    final response = await _realtimeDatabaseService.getData(
      path: _pathProductGetFavorites,
      requiresAuth: true,
    );
    ProductListDecodable decodable = ProductListDecodable.fromMap(response);
    return decodable;
  }

  @override
  Future<bool> addBusinessFavorite({required String businessId}) async {
    final response = await _realtimeDatabaseService.postData(
      bodyParameters: {"business_id": businessId},
      path: _pathBusinessCreateFavorite,
      requiresAuth: true,
    );
    if (response.isEmpty) {
      return Future.error("Error: No hay respuesta del servidor.");
    }

    // Si la respuesta contiene 'detail', significa que hubo un error
    print("Esto contiene response en favorites_repository: ${response}");
    if (response.containsKey("detail")) {
      final detailList = response["detail"];
      if (detailList is List && detailList.isNotEmpty) {
        final errorMessage = detailList.first["msg"] ?? "Error desconocido";
        return Future.error(errorMessage);
      }
      return Future.error("Error desconocido del servidor.");
    }

    // Si la respuesta contiene 'message', significa que fue exitosa
    if (response.containsKey("message") &&
        response["message"] == "Negocio agregado a favoritos correctamente") {
      return true;
    }

    return Future.error("Error desconocido");
  }

  @override
  Future<bool> addProductFavorite({required String productId}) async {
    final response = await _realtimeDatabaseService.postData(
      bodyParameters: {"product_id": productId},
      path: _pathProductCreateFavorite,
      requiresAuth: true,
    );
    if (response.isEmpty) {
      return Future.error("Error: No hay respuesta del servidor.");
    }

    if (response.containsKey("detail")) {
      print("Esto contiene response en favorites_repository: ${response}");
      final detailList = response["detail"];
      if (detailList is List && detailList.isNotEmpty) {
        final errorMessage = detailList.first["msg"] ?? "Error desconocido";
        return Future.error(errorMessage);
      }
      return Future.error("Error desconocido del servidor.");
    }

    if (response.containsKey("message") &&
        response["message"] == "Producto agregado a favoritos correctamente") {
      return true;
    }

    return Future.error("Error desconocido");
  }

  @override
  Future<bool> removeBusinessFavorite({required String businessId}) async {
    String path = _pathBusinessDeleteFavorite + businessId.toString();
    final response = await _realtimeDatabaseService.deleteData(
      path: path,
      requiresAuth: true,
    );
    if (response.isEmpty) {
      return Future.error("Error: No hay respuesta del servidor.");
    }

    if (response.containsKey("detail")) {
      final detailList = response["detail"];
      if (detailList is List && detailList.isNotEmpty) {
        final errorMessage = detailList.first["msg"] ?? "Error desconocido";
        return Future.error(errorMessage);
      }
      return Future.error("Error desconocido del servidor.");
    }

    if (response.containsKey("message") &&
        response["message"] == "Negocio favorito eliminado correctamente") {
      return true;
    }

    return Future.error("Error desconocido");
  }

  @override
  Future<bool> removeProductFavorite({required String productId}) async {
    String path = _pathProductDeleteFavorite + productId.toString();
    final response = await _realtimeDatabaseService.deleteData(
      path: path,
      requiresAuth: true,
    );
    if (response.isEmpty) {
      return Future.error("Error: No hay respuesta del servidor.");
    }

    if (response.containsKey("detail")) {
      final detailList = response["detail"];
      if (detailList is List && detailList.isNotEmpty) {
        final errorMessage = detailList.first["msg"] ?? "Error desconocido";
        return Future.error(errorMessage);
      }
      return Future.error("Error desconocido del servidor.");
    }

    if (response.containsKey("message") &&
        response["message"] == "Producto favorito eliminado correctamente") {
      return true;
    }

    return Future.error("Error desconocido");
  }
}
