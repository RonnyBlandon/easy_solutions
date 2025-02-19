import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/presentation/forgot_password_page/ViewModel/forgot_password_view_model.dart';
import 'package:easy_solutions/src/utils/Helpers/Validators/form_validators.dart';
import 'package:flutter/material.dart';

class TextFormFieldEmailResetPassword extends StatelessWidget {
  final ForgotPasswordViewModel viewModel;
  const TextFormFieldEmailResetPassword({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: bgInputs, borderRadius: BorderRadius.circular(40.0)),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            hintText: "Correo electrónico",
            border: OutlineInputBorder(borderSide: BorderSide.none)),
        validator: (value) =>
            EmailFormValidator.validateEmail(email: value ?? ""),
        onChanged: (newValue) => viewModel.email = newValue,
      ),
    );
  }
}
