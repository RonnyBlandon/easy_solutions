import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//Colors
import 'package:easy_solutions/src/colors/colors.dart';

//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: backButton(context, Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Column(
            children: [
              headerText(text: 'Crea una cuenta', color: black),
              _namesInput(context),
              _surnamesInput(context),
              _emailInput(context),
              _phoneInput(context),
              _passwordInput(context),
              _repeatPasswordInput(context),
              _signUpButton(context),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text:
                            'Al hacer clic en Registrarse aceptas los siguientes',
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                      TextSpan(
                        text: ' Términos y Condiciones',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, 'welcome');
                          },
                      ),
                      const TextSpan(
                        text: ' sin reservas.',
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _namesInput(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 20.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: bgInputs, borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Nombres',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(0.0)),
    ),
  );
}

Widget _surnamesInput(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 20.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: bgInputs, borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Apellidos',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(0.0)),
    ),
  );
}

Widget _emailInput(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 15.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: bgInputs, borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Correo electrónico',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(0.0)),
    ),
  );
}

Widget _phoneInput(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 15.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: bgInputs, borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintText: 'Teléfono',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(0.0)),
    ),
  );
}

Widget _passwordInput(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 15.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: bgInputs, borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Contraseña',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(0.0)),
    ),
  );
}

Widget _repeatPasswordInput(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 15.0, bottom: 20.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: bgInputs, borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Repita la Contraseña',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(0.0)),
    ),
  );
}

Widget _signUpButton(BuildContext context) {
  return createElevatedButton(onPressed: () {}, labelButton: 'Registrarse');
}
