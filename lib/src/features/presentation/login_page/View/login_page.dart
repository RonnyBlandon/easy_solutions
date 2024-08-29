import 'package:flutter/material.dart';
// Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          Stack(
            children: [
              const Image(
                  width: double.infinity,
                  height: 300.0,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/login_back_image.jpg')),
              Container(
                  margin: const EdgeInsets.only(top: 40.0),
                  child: backButton(context, Colors.white))
            ],
          ),
          Transform.translate(
            offset: const Offset(0.0, -20.0),
            child: Container(
              width: double.infinity,
              height: 456,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Center(
                  child: Column(
                    children: [
                      headerText(text: '!Bienvenido¡'),
                      const Text(
                        'Inicie sesión en su cuenta',
                        style: TextStyle(
                            color: grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      _emailInput(),
                      _passwordInput(),
                      const SizedBox(height: 30.0),
                      _loginButton(context),
                      const SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'forgot_password');
                        },
                        child: const Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿No tienes cuenta?',
                            style: TextStyle(
                                color: grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.0),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'sign_up');
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: const Text(
                                'Registrate',
                                style: TextStyle(
                                    color: orange,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _emailInput() {
  return Container(
    margin: const EdgeInsets.only(top: 30.0),
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

Widget _passwordInput() {
  return Container(
    margin: const EdgeInsets.only(top: 15.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: bgInputs, borderRadius: BorderRadius.circular(30.0)),
    child: const TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Contraseña',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget _loginButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 5.0),
    child: createElevatedButton(
        labelButton: 'Inicie Sesión',
        onPressed: () {
          Navigator.pushNamed(context, 'tabs');
        }),
  );
}
