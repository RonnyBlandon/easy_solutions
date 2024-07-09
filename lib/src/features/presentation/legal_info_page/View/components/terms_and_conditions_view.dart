import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(
            text: 'Terminos y condiciones',
            color: Colors.black,
            fontsize: 18.0),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Terminos y condiciones'),
      ),
    );
  }
}
