import 'package:flutter/material.dart';

const borderRadius = BorderRadius.all(Radius.circular(20.0));
const boxShadows = [
  BoxShadow(
      color: Color.fromRGBO(210, 211, 215, 1.0),
      spreadRadius: 1.0,
      blurRadius: 4.0)
];

Decoration createBoxDecorationWithShadows(
    {BorderRadiusGeometry borderRadius = borderRadius,
    Color containerColor = Colors.white,
    List<BoxShadow> boxShadows = boxShadows}) {
  return BoxDecoration(
      borderRadius: borderRadius, color: containerColor, boxShadow: boxShadows);
}
