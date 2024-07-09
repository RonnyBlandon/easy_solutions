import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';

class EmptyNotificationsView extends StatelessWidget {
  const EmptyNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              color: Colors.amber,
              Icons.notifications,
              size: 150.0,
            ),
            headerText(
                text: 'No tienes nuevas notificaciones. 📭',
                color: Colors.grey,
                fontsize: 25.0),
            const SizedBox(height: 10.0),
            const Text(
              'No tienes nuevas notificaciones por ahora. Revisa más tarde para estar al tanto de cualquier actualización o mensaje importante. 📅🔔',
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
