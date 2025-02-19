import 'package:flutter/material.dart';

Widget createElevatedButton(
    {BuildContext? context,
    double width = 300.0,
    double height = 40.0,
    double radius = 20.0,
    double fontSize = 16.0,
    Color backgroundColor = Colors.orange,
    Color foregroundColor = Colors.white,
    bool isWithIcon = false,
    ImageProvider<Object> icon = const AssetImage(''),
    String labelButton = '',
    void Function()? onPressed}) {
  return SizedBox(
    width: width,
    height: height,
    child: isWithIcon
        ? _elevatedButtonWithIcon(radius, icon, labelButton, fontSize,
            backgroundColor, foregroundColor, onPressed)
        : _elevatedButtonNotIcon(radius, labelButton, fontSize, backgroundColor,
            foregroundColor, onPressed),
  );
}

//AssetImage('assets/images/google_icono.png') 'Iniciar Sesión con Google', 'Iniciar Sesión con Google'
Widget _elevatedButtonWithIcon(
    double radius,
    ImageProvider<Object> icon,
    String labelButton,
    double fontSize,
    Color backgroundColor,
    Color foregroundColor,
    void Function()? onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      overlayColor: Colors.black,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(image: icon, width: 30.0, height: 30.0),
        const SizedBox(width: 10),
        Text(labelButton, style: TextStyle(fontSize: fontSize)),
      ],
    ),
  );
}

Widget _elevatedButtonNotIcon(
    double radius,
    String labelButton,
    double fontSize,
    Color backgroundColor,
    Color foregroundColor,
    void Function()? onPressed) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        overlayColor: Colors.black,
      ),
      child: Text(labelButton, style: TextStyle(fontSize: fontSize)));
}
