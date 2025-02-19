import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(
            text: 'Politica de privacidad',
            color: Colors.black,
            fontsize: 18.0),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Politica de privacidad'),
      ),
    );
  }
}
