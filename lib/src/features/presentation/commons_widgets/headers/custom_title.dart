import 'package:flutter/material.dart';

Widget customTitle(String title, Color color,
    {double fontsize = 30.0,
    TextAlign textAling = TextAlign.center,
    FontWeight fontWeight = FontWeight.bold}) {
  return Text(
    title,
    textAlign: textAling,
    style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontsize,
        decoration: TextDecoration.none),
  );
}
