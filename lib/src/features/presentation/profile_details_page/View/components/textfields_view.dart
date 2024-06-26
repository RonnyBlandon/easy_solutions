import 'package:flutter/material.dart';
//Extensions
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';

class TextfieldsProfileDetailView extends StatelessWidget {
  const TextfieldsProfileDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _createTextFieldNames(context),
        _createTextFieldSurnames(context),
        _createTextFieldEmail(context),
        _createTextFieldPhone(context),
      ],
    );
  }
}

Widget _createTextFieldNames(BuildContext context) {
  return Container(
    width: screenWidth.getScreenWidth(context: context, multiplier: 0.85),
    decoration:
        const BoxDecoration(border: Border(bottom: BorderSide(color: grey))),
    child: const ListTile(
      title: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Nombres',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(0.0),
        ),
      ),
    ),
  );
}

Widget _createTextFieldSurnames(BuildContext context) {
  return Container(
    width: screenWidth.getScreenWidth(context: context, multiplier: 0.85),
    decoration:
        const BoxDecoration(border: Border(bottom: BorderSide(color: grey))),
    child: const ListTile(
      title: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Apellidos',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(0.0),
        ),
      ),
    ),
  );
}

Widget _createTextFieldEmail(BuildContext context) {
  return Container(
    width: screenWidth.getScreenWidth(context: context, multiplier: 0.85),
    decoration:
        const BoxDecoration(border: Border(bottom: BorderSide(color: grey))),
    child: const ListTile(
      title: TextField(
        readOnly: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Correo electrónico',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(0.0),
        ),
      ),
    ),
  );
}

Widget _createTextFieldPhone(BuildContext context) {
  return Container(
    width: screenWidth.getScreenWidth(context: context, multiplier: 0.85),
    decoration:
        const BoxDecoration(border: Border(bottom: BorderSide(color: grey))),
    child: const ListTile(
      title: TextField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Teléfono',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(0.0),
        ),
      ),
    ),
  );
}
