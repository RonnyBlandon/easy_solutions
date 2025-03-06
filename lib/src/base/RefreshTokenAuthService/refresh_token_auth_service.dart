import 'dart:convert';
import 'package:easy_solutions/src/base/TokenStorageService/token_storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:easy_solutions/src/base/ApiService/app_error.dart';

class RefreshTokenAuthService {
  final TokenStorageService _tokenStorage = TokenStorageService();
  static const String _refreshTokenUrl = "http://192.168.0.3:8000/auth/refreshToken";

  Future<bool> refreshAccessToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    print("Esto tiene refresToken en refresh_token_auth_service: $refreshToken");
    if (refreshToken == null) {
      return false; // No hay refresh token, usuario debe iniciar sesión de nuevo
    }

    try {
      final response = await http.post(
        Uri.parse(_refreshTokenUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"refresh_token": refreshToken}),
      ).timeout(const Duration(seconds: 25));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final newAccessToken = jsonData["access_token"];
        final newRefreshToken = jsonData["refresh_token"];

        // Guardar nuevos tokens
        await _tokenStorage.saveAccessToken(newAccessToken);
        await _tokenStorage.saveRefreshToken(newRefreshToken);

        return true; // Token actualizado correctamente
      } else {
        await _tokenStorage.clearTokens(); // Eliminar tokens si falló
        return false;
      }
    } catch (e) {
      throw Failure.fromMessage(message: "Error al refrescar el token");
    }
  }
}
