import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';

class EmptyOrderView extends StatelessWidget {
  const EmptyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: AppBar(
        elevation: 0.1,
        leading: const Text(''),
        backgroundColor: white,
        title: customTitle('Mis Pedidos', Colors.black, fontsize: 18.0),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment,
              size: 150.0,
            ),
            customTitle('¡Tu historial de pedidos está vacío! 🤔', Colors.grey,
                fontsize: 25.0),
            const SizedBox(height: 10.0),
            const Text(
              'Realiza tu primer pedido para acceder al historial y estado de tus entregas. 🍔📦',
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