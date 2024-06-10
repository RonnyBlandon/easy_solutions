import 'package:flutter/material.dart';

Widget customTitle(String title, Color color, {double fontsize = 30.0}) {
  return Text(
    title,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontsize,
        decoration: TextDecoration.none),
  );
}
