abstract class AppFailureMessages {
  // Error Message
  static String unExpectedErrorMessage = "Ha ocurrido un error inesperado.";
}

abstract class ApiFailureMessages {
  // Error messages
  static String invalidLoginCredentialsMessage =
      "Correo o contraseña incorrectos. Inténtalo de nuevo.";
  static String emailNotFoundMessage =
      "No existe ningún registro de usuario correspondiente a este identificador.";
  static String invalidPasswordMessage =
      "La contraseña no es válida o el usuario no tiene contraseña.";
  static String emailExitMessage =
      "La dirección de correo electrónico ya esta siendo utilizada por otra cuenta.";
  static String tooManyAttemptsMessage =
      "Hemos bloqueado todas las solicitudes de este dispositivo debido a un aactividad inusual. Vuelve a intentarlo mas tarde.";
  static String invalidIdTokenMessage =
      "La credencial del usuario ya no es valida. El usuario debe iniciar sesión nuevamente.";
  static String userNotFoundMessage =
      "No hay ningún registro de usuario que corresponda a este identificador.";
}
