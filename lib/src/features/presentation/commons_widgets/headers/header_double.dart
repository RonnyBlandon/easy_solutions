import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:flutter/material.dart';

Widget headerDoubleText(
    {required String textHeader,
    required String textAction,
    void Function()? onPressed}) {
  return Row(
    children: [
      headerText(text: textHeader, fontsize: 20.0),
      const Spacer(),
      GestureDetector(
        onTap: onPressed,
        child: headerText(
          text: textAction,
          color: Colors.orange,
          fontsize: 15.0,
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  );
}
