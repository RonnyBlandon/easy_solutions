import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/utils/Helpers/Validators/form_validators.dart';
import 'package:flutter/material.dart';

abstract class TextFormFieldDelegate {
  void onChanged({
    required String newValue,
    required CustomTextFormFieldType customTextFormFieldType,
  });
}

enum CustomTextFormFieldType { email, password, phone, username }

class CustomTextFormField extends StatelessWidget {
  final CustomTextFormFieldType textFormFieldType;
  final String hintext;
  final TextFormFieldDelegate delegate;
  final TextEditingController? _controller;

  const CustomTextFormField({
    super.key,
    required this.textFormFieldType,
    required this.hintext,
    required this.delegate,
    TextEditingController? controller,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    // Notificador para manejar el estado de visibilidad de la contraseña
    final ValueNotifier<bool> obscureTextNotifier = ValueNotifier<bool>(
        textFormFieldType == CustomTextFormFieldType.password);

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: bgInputs, borderRadius: BorderRadius.circular(40.0)),
      child: ValueListenableBuilder(
        valueListenable: obscureTextNotifier,
        builder: (context, obscureText, child) {
          return TextFormField(
            controller: _controller,
            keyboardType: getKeyBoardType(textFormFieldType: textFormFieldType),
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintext,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              // Mostrar el icono de visibilidad solo para campos de contraseña
              suffixIcon: textFormFieldType == CustomTextFormFieldType.password
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        obscureTextNotifier.value = !obscureTextNotifier.value;
                      },
                    )
                  : null,
            ),
            onChanged: (newValue) => delegate.onChanged(
                newValue: newValue, customTextFormFieldType: textFormFieldType),
            validator: (value) {
              switch (textFormFieldType) {
                case CustomTextFormFieldType.email:
                  return EmailFormValidator.validateEmail(email: value ?? "");
                case CustomTextFormFieldType.password:
                  return PasswordFormValidator.validatePassword(
                      password: value ?? "");
                case CustomTextFormFieldType.phone:
                  return DefaultFormValidator.validateIsNotEmpty(
                      value: value ?? "");
                case CustomTextFormFieldType.username:
                  return DefaultFormValidator.validateIsNotEmpty(
                      value: value ?? "");
              }
            },
          );
        },
      ),
    );
  }

  TextInputType? getKeyBoardType(
      {required CustomTextFormFieldType textFormFieldType}) {
    switch (textFormFieldType) {
      case CustomTextFormFieldType.email:
        return TextInputType.emailAddress;
      case CustomTextFormFieldType.password:
        return TextInputType.visiblePassword;
      case CustomTextFormFieldType.phone:
        return TextInputType.phone;
      case CustomTextFormFieldType.username:
        return TextInputType.text;
    }
  }
}
