import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              width: 180.0,
              height: 180.0,
              image: AssetImage('assets/images/shopping_basket.png'),
            ),
            headerText(
                text: 'Carrito Vacío', color: Colors.grey, fontsize: 25.0),
            const Text(
              'Agrega al carrito lo que más te guste.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
