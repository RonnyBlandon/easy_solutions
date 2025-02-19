import 'package:flutter/material.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';

void showAlertDialogWithImage(
    BuildContext context,
    ImageProvider<Object> imagePath,
    String headerTitle,
    String headerSubTitle,
    String labelButton,
    bool barrierDismissible,
    void Function() doneButtonFunc) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(image: imagePath, width: 150.0, height: 150.0),
            Text(
              headerTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            const SizedBox(height: 15.0),
            Text(
              headerSubTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
            ),
            const SizedBox(height: 15.0),
            createElevatedButton(
                labelButton: labelButton, onPressed: doneButtonFunc)
          ],
        ),
      );
    },
  );
}
