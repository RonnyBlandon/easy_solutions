import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
import 'package:flutter/material.dart';

class ErrorAlertView {
  static Future showErrorAlertDialog(
      {required BuildContext context,
      required String subtitle,
      dynamic Function()? ctaButtonAction}) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SizedBox(
              height: 320,
              child: Column(
                children: [
                  const Image(
                    image: AssetImage('assets/images/error-icon.png'),
                    width: 130,
                    height: 130,
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    child: const Text(
                      'Network error',
                      style: TextStyle(color: primaryColor, fontSize: 20.0),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  createElevatedButton(
                      onPressed: ctaButtonAction, labelButton: 'Ir a inicio')
                ],
              ),
            ),
          );
        });
  }
}
