import 'package:easy_solutions/src/colors/colors.dart';
import 'package:flutter/material.dart';
import '../../TextView/View/text_view.dart';

class DoubleTextView extends StatelessWidget {

  final String textHeader;
  final String textAction;
  final Function()? textActionTapped;

  const DoubleTextView({super.key,   
    required this.textHeader,
    required this.textAction,
    this.textActionTapped
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextView(texto: textHeader, fontSize: 20.0),
        const Spacer(),
        GestureDetector(
          onTap: textActionTapped,
          child: TextView(
              texto: textAction,
              color: orange,
              fontWeight: FontWeight.w500,
              fontSize: 15.0),
        )
      ],
    );
  }
}