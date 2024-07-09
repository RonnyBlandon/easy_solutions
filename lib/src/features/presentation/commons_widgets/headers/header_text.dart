import 'package:flutter/material.dart';

Widget headerText(
    {required String text,
    Color color = Colors.black,
    double fontsize = 30.0,
    TextAlign textAling = TextAlign.center,
    FontWeight fontWeight = FontWeight.bold,
    int? maxLines,
    TextOverflow? overflow}) {
  return Text(
    text,
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
