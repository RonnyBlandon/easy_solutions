import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';

class EmptyPaymentMethodsView extends StatelessWidget with BaseView {
  EmptyPaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.payment, color: Colors.orange, size: 150.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: headerText(
                text:
                    'Añade una tarjeta y disfruta de pagos más sencillos. 💳✨',
                color: Colors.grey,
                fontsize: 25.0,
              ),
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Registra tu tarjeta de crédito o débito con nosotros para agilizar tus compras y evitar el ingreso de datos en cada transacción. 💳⏱️ ¡Es rápido, seguro y te ahorra tiempo! ⏳👍',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            createElevatedButton(
              onPressed: () {
                coordinator.showAddEditCardPage(
                  context: context,
                  isForEditing: false,
                );
              },
              labelButton: 'Agregar tarjeta',
            ),
          ],
        ),
      ),
    );
  }
}
