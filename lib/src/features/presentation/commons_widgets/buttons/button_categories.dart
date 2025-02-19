import 'package:flutter/material.dart';

class ButtonCategories extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final String networkImage;
  final double height;
  final double fontSize;
  final double marginBottom;
  final Color textColor;
  final Color textBackgroundColor;
  final TextDecoration decoration;
  final double decorationThickness;

  const ButtonCategories(
      {super.key,
      this.onTap,
      required this.text,
      required this.networkImage,
      this.height = 180.0,
      this.fontSize = 26.0,
      this.marginBottom = 15.0,
      this.textColor = Colors.white,
      this.textBackgroundColor = Colors.black,
      this.decoration = TextDecoration.none,
      this.decorationThickness = 1.5});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: height,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(networkImage))),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            margin: EdgeInsets.only(bottom: marginBottom),
            decoration: BoxDecoration(
                color: textBackgroundColor,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                decoration: decoration,
                //decorationColor: Colors.white,
                //decorationThickness: decorationThickness,
              ),
            ),
          )),
    );
  }
}
