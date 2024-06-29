import 'package:flutter/material.dart';

Widget customTitle(String title, Color color,
    {double fontsize = 30.0,
    TextAlign textAling = TextAlign.center,
    FontWeight fontWeight = FontWeight.bold,
    int? maxLines,
    TextOverflow? overflow}) {
  return Text(
    title,
    textAlign: textAling,
    maxLines: maxLines,
    overflow: overflow,
    style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontsize,
        decoration: TextDecoration.none),
  );
}
