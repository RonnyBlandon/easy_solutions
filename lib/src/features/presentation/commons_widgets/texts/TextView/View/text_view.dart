import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String texto;
  final Color color;
  final FontWeight fontWeight;
  final double? fontSize;
  final TextAlign textAlign;
  final int? maxLines;

  const TextView({super.key,  this.texto = "",
                   this.color = Colors.black,
                   this.fontWeight = FontWeight.bold,
                   this.fontSize,
                   this.textAlign = TextAlign.left,
                   this.maxLines = 2 });

  @override
  Widget build(BuildContext context) {
    return Text(texto,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        style: TextStyle(color: color,
                         fontWeight: fontWeight,
                         fontSize: fontSize));
  }
}
