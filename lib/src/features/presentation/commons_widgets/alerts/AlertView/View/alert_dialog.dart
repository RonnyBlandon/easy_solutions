import 'package:flutter/material.dart';
// Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';

class AlertView {
  static Future showAlertDialog({
    required BuildContext context,
    ImageProvider<Object>? imagePath,
    required String headerTitle,
    required String headerSubTitle,
    required String labelButton,
    Color backgroundColorButton = Colors.orange,
    Color foregroundColorButton = Colors.white,
    required bool isDismissible,
    String? cancelText,
    void Function()? cancelAction,
    void Function()? doneButtonFunc,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imagePath != null)
                Image(image: imagePath, width: 150.0, height: 150.0),
              Text(
                headerTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 15.0),
              if (headerSubTitle.isNotEmpty) ...[
                Text(
                  headerSubTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 15.0),
              ],
              createElevatedButton(
                labelButton: labelButton,
                onPressed: doneButtonFunc,
                backgroundColor: backgroundColorButton,
              ),
              if (cancelText?.isNotEmpty ?? false) ...[
                const SizedBox(height: 20.0),
                createElevatedButton(
                  labelButton: cancelText ?? "",
                  onPressed: cancelAction,
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  static closeAlertDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
