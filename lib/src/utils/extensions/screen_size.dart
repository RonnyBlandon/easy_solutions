import 'package:flutter/material.dart';

//Extención pública
double screenWidth = 0;
double screenHeight = 0;

extension ScreenSize on double {
  double getScreenWidth(
      {required BuildContext context, double multiplier = 1.0}) {
    var width = MediaQuery.of(context).size.width;
    width = width * multiplier;

    return width;
  }

  double getScreenHeight(
      {required BuildContext context, double multiplier = 1.0}) {
    var height = MediaQuery.of(context).size.height;
    height = height * multiplier;

    return height;
  }
}
