import 'package:easy_solutions/src/colors/colors.dart';
import 'package:flutter/material.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';

class EmptyAddressState extends StatelessWidget {
  const EmptyAddressState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_pin,
              color: Colors.orange,
              size: 150.0,
            ),
            customTitle(
                '¡Aún no hay una dirección registrada.! 🤔', Colors.grey,
                fontsize: 25.0),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Para asegurarnos de que tu pedido llegue correctamente, necesitamos que nos des una dirección de entrega.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10.0),
            createElevatedButton(
                onPressed: () {}, labelButton: 'Agregar dirección')
          ],
        ),
      ),
    );
  }
}
