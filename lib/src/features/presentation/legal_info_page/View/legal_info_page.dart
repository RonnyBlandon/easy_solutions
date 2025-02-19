import 'package:easy_solutions/src/features/presentation/legal_info_page/View/components/privacy_policy_view.dart';
import 'package:easy_solutions/src/features/presentation/legal_info_page/View/components/terms_and_conditions_view.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';

class LegalInfoPage extends StatelessWidget {
  const LegalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(text: 'Información Legal', fontsize: 18.0),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 35.0),
            alignment: Alignment.center,
            child: createElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const TermsAndConditionsView()),
                  );
                },
                labelButton: 'Términos y condiciones',
                radius: 10.0,
                backgroundColor: Colors.blue),
          ),
          Container(
            margin: const EdgeInsets.only(top: 35.0),
            alignment: Alignment.center,
            child: createElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyView()),
                  );
                },
                labelButton: 'Política de privacidad',
                radius: 10.0,
                backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }
}
