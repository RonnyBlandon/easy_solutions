import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget with BaseView {
  final String assetImagePath;
  final String errorTitle;
  final String errorSubTitle;
  final String buttonText;
  final VoidCallback onButtonPressed;

  ErrorView({
    super.key,
    this.assetImagePath = 'assets/images/error-icon.png',
    this.errorTitle = 'Ocurrió un error',
    this.errorSubTitle = 'Algo salió mal, por favor intenta nuevamente.',
    this.buttonText = 'Ir a Inicio',
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: getScreenHeight(context: context, multiplier: 0.1),
            bottom: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(width: 216, height: 216, image: AssetImage(assetImagePath)),
              const SizedBox(height: 30),
              headerText(
                text: errorTitle,
                color: grey,
                fontsize: 25,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: headerText(
                  text: errorSubTitle,
                  textAling: TextAlign.center,
                  color: grey,
                  fontsize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              createElevatedButton(
                width: 300,
                onPressed: onButtonPressed,
                backgroundColor: orange,
                labelButton: buttonText,
                radius: 10.0,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
