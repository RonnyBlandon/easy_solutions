import 'package:flutter/material.dart';

//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/alerts/alert_dialog_with_image.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: backButton(context, Colors.black),
        ),
        body: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                customTitle('Olvidaste tu contraseña', black, fontsize: 29.0),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Por favor, ingrese su correo electrónico para recuperar su contraseña.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                ),
                _emailInput(),
                const SizedBox(height: 30.0),
                _sendButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _emailInput() {
  return Container(
    margin: const EdgeInsets.only(top: 20.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: bgInputs, borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Correo electrónico',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget _sendButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      _showAlertPassword(context);
    },
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        overlayColor: Colors.black,
        minimumSize: const Size(300, 40)),
    child: const Text(
      'Enviar',
      style: TextStyle(fontSize: 16.0),
    ),
  );
}

void _showAlertPassword(BuildContext context) {
  return showAlertDialogWithImage(
    context,
    const AssetImage('assets/images/forgot_password.png'),
    'Tu contraseña ha sido restablecida',
    'Recibirá un código en su correo electrónico para restablecer su contraseña.',
    'Hecho',
    false,
    () {
      Navigator.of(context).pop();
      Navigator.pushNamed(context, 'login');
    },
  );
}
