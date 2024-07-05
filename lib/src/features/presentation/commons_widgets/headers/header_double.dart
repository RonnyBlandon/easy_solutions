import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
import 'package:flutter/material.dart';

Widget headerDoubleText(
    {required String textHeader,
    required String textAction,
    void Function()? onPressed}) {
  return Row(
    children: [
      customTitle(textHeader, Colors.black, fontsize: 20.0),
      const Spacer(),
      GestureDetector(
        onTap: onPressed,
        child: customTitle(
          textAction,
          Colors.orange,
          fontsize: 15.0,
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  );
}
