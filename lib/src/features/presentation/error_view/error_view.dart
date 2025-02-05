import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget with BaseView {
  bool isLocationDeniedError = false;
  String assetImagePath = "";
  String errorTitle = "";
  String errorSubTitle = "";

  ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    setErrorViewData();
    return Scaffold(
      backgroundColor: bgGreyPage,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
              top: getScreenHeight(context: context, multiplier: 0.1),
              bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(width: 216, height: 216, image: AssetImage(assetImagePath)),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: headerText(
                    text: errorTitle,
                    color: grey,
                    fontsize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: headerText(
                    text: errorSubTitle,
                    textAling: TextAlign.center,
                    color: grey,
                    fontsize: 17,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              createElevatedButton(
                  width: 300,
                  onPressed: () {
                    if (isLocationDeniedError) {
                      // TODO: Crear feature de añadir dirección de entrega
                    } else {
                      coordinator.showTabsPage(context: context);
                    }
                  },
                  backgroundColor: orange,
                  labelButton: isLocationDeniedError
                      ? "Establecer dirección de entrega"
                      : "Ir a Inicio",
                  radius: 10.0),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }

  setErrorViewData() {
    assetImagePath = isLocationDeniedError
        ? 'assets/images/location-google.png'
        : 'assets/images/error-icon.png';
    errorTitle =
        isLocationDeniedError ? 'Location Denied Error' : 'Error de Red';
    errorSubTitle = isLocationDeniedError
        ? 'Algo malo sucedió. Sin tu ubicación actual, la aplicación no puede seguir funcionando correctamente. \n\n Puedes pedir cualquier cosa, solo indica en qué dirección'
        : 'Algo malo sucedió, la aplicación no puede seguir funcionando correctamente.';
  }
}
