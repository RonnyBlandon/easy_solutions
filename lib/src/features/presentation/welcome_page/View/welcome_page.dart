import 'dart:ui';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/rounded_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  'assets/images/welcome_image.jpg'), // Paréntesis de cierre añadido
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: customTitle(
                  'ENTREGAS A DOMICILIO HASTA LA PUERTA DE TU CASA', white)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              'Proporcione su ubicación exacta para encontrar los servicios de entrega más adecuados cerca de usted',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  decoration: TextDecoration.none),
            ),
          ),
          createElevatedButton(
              isWithIcon: false,
              labelButton: 'Iniciar Sesión',
              onPressed: () {
                Navigator.pushNamed(context, 'login');
              }),
          const SizedBox(height: 20),
          createElevatedButton(
              isWithIcon: true,
              icon: const AssetImage('assets/images/google_icono.png'),
              labelButton: 'Iniciar Sesión con Google',
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: () {})
        ]),
      ],
    );
  }
}
