import 'dart:convert';
import 'package:easy_solutions/src/base/Constants/error_messages.dart';
import 'package:easy_solutions/src/services/EasyDeliveryServices/AuthEasyDeliveryServices/Decodables/auth_error_decodable.dart';

class Failure {
  String? message;
  Map<String, dynamic> error = {};

  @override
  String toString() => message ?? "Hubo un error inesperado.";

  Failure.fromMessage({this.message});

  Failure.fromBody({required String body}) {
    try {
      var jsonData = jsonDecode(body);
      error = jsonData;
    } catch (e) {
      print("Error al decodificar el cuerpo de la respuesta: $e");
      message = "Error desconocido en el servidor.";
    }
  }

  static Failure getApiAuthErrorMessage({required Map<String, dynamic> error}) {
    AuthErrorDecodable errorDecodable = AuthErrorDecodable.fromMap(error);

    var message = "";

    // Verificar si `detailMessage` está disponible o si hay errores en `detailErrors`
    if (errorDecodable.detailMessage != null) {
      message = errorDecodable.detailMessage!;
    } else if (errorDecodable.detailErrors != null &&
        errorDecodable.detailErrors!.isNotEmpty) {
      errorDecodable.detailErrors!.forEach((errorDetail) {
        message = errorDetail.msg ?? "";
      });
    }

    // Mapear el mensaje de error a los mensajes predefinidos de la aplicación
    if (message == "INVALID_LOGIN_CREDENTIALS") {
      return Failure.fromMessage(
          message: ApiFailureMessages.invalidLoginCredentialsMessage);
    } else if (message == "EMAIL_NOT_FOUND") {
      return Failure.fromMessage(
          message: ApiFailureMessages.emailNotFoundMessage);
    } else if (message == "INVALID_PASSWORD") {
      return Failure.fromMessage(
          message: ApiFailureMessages.invalidPasswordMessage);
    } else if (message == "EMAIL_EXISTS") {
      return Failure.fromMessage(message: ApiFailureMessages.emailExitMessage);
    } else if (message == "TOO_MANY_ATTEMPTS_TRY_LATER") {
      return Failure.fromMessage(
          message: ApiFailureMessages.tooManyAttemptsMessage);
    } else if (message == "INVALID_ID_TOKEN") {
      return Failure.fromMessage(
          message: ApiFailureMessages.invalidIdTokenMessage);
    } else if (message == "USER_NOT_FOUND") {
      return Failure.fromMessage(
          message: ApiFailureMessages.userNotFoundMessage);
    } else {
      return Failure.fromMessage(
          message: message.isNotEmpty ? message : "Error desconocido.");
    }
  }
}
