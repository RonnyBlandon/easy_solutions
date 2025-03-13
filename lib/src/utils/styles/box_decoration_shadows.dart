import 'package:easy_solutions/src/colors/colors.dart';
import 'package:flutter/material.dart';

// Constants
const borderRadius = BorderRadius.all(Radius.circular(20.0));
const boxShadows = [
  BoxShadow(
    color: Color.fromRGBO(210, 211, 215, 1.0),
    spreadRadius: 1.0,
    blurRadius: 4.0,
  ),
];

const _defectBoxShadowObject = [
  BoxShadow(
    color: Color.fromRGBO(210, 211, 215, 1.0),
    offset: Offset(0, 5),
    blurRadius: 10.0,
  ),
];

const BorderSide defaultBorderSide = BorderSide(color: orange);

const Decoration defaultTextFieldDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(8)),
  border: Border(
    top: defaultBorderSide,
    left: defaultBorderSide,
    bottom: defaultBorderSide,
    right: defaultBorderSide,
  ),
);

Decoration createBoxDecorationWithShadows({
  BorderRadiusGeometry borderRadius = borderRadius,
  Color containerColor = Colors.white,
  List<BoxShadow> boxShadows = boxShadows,
}) {
  return BoxDecoration(
    borderRadius: borderRadius,
    color: containerColor,
    boxShadow: boxShadows,
  );
}

BoxDecoration getBoxDecorationWithShadows({
  BorderRadiusGeometry borderRadius = borderRadius,
  Color containerColor = Colors.white,
  List<BoxShadow> boxShadows = _defectBoxShadowObject,
}) {
  return BoxDecoration(
    borderRadius: borderRadius,
    color: containerColor,
    boxShadow: boxShadows,
  );
}
