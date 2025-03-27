import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/utils/Helpers/Validators/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import necesario para inputFormatters

mixin TextFormFieldDelegate {
  void onChanged({
    required String newValue,
    required CustomTextFormFieldType customTextFormFieldType,
  });
}

enum CustomTextFormFieldType {
  email,
  password,
  phone,
  username,
  nameInTheCard,
  cardNumber,
  monthAndYearInCard,
  cvc,
  country,
  address,
  reference,
  municipality,
  sector,
  cp,
  notes,
  alias,
}

class CustomTextFormField extends StatelessWidget {
  final CustomTextFormFieldType textFormFieldType;
  final String hintext;
  final TextFormFieldDelegate delegate;
  final TextEditingController? _controller;
  final Decoration? _decoration;
  final String? _initialValue;
  final Widget? _icon;
  final List<TextInputFormatter>? inputFormatters; // Nuevo parámetro

  const CustomTextFormField({
    super.key,
    required this.textFormFieldType,
    required this.hintext,
    required this.delegate,
    TextEditingController? controller,
    Decoration? decoration,
    String? initialValue,
    Widget? icon,
    this.inputFormatters, // Inicializar aquí
  }) : _controller = controller,
       _decoration = decoration,
       _initialValue = initialValue,
       _icon = icon;

  @override
  Widget build(BuildContext context) {
    // Notificador para manejar el estado de visibilidad de la contraseña
    final ValueNotifier<bool> obscureTextNotifier = ValueNotifier<bool>(
      textFormFieldType == CustomTextFormFieldType.password,
    );

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration:
          _decoration ??
          BoxDecoration(
            color: bgInputs,
            borderRadius: BorderRadius.circular(40.0),
          ),
      child: ValueListenableBuilder(
        valueListenable: obscureTextNotifier,
        builder: (context, obscureText, child) {
          return TextFormField(
            controller: _controller,
            initialValue: _initialValue,
            keyboardType: _getKeyBoardType(
              textFormFieldType: textFormFieldType,
            ),
            obscureText: obscureText,
            decoration: InputDecoration(
              icon: _icon,
              hintText: hintext,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              suffixIcon:
                  textFormFieldType == CustomTextFormFieldType.password
                      ? IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          obscureTextNotifier.value =
                              !obscureTextNotifier.value;
                        },
                      )
                      : null,
            ),
            // Aplicar los inputFormatters o por defecto para phone
            inputFormatters:
                inputFormatters ??
                (textFormFieldType == CustomTextFormFieldType.phone
                    ? [
                      FilteringTextInputFormatter.digitsOnly, // Solo dígitos
                      LengthLimitingTextInputFormatter(8), // Máximo 8 dígitos
                    ]
                    : null),
            onChanged:
                (newValue) => delegate.onChanged(
                  newValue: newValue,
                  customTextFormFieldType: textFormFieldType,
                ),
            validator: (value) {
              switch (textFormFieldType) {
                case CustomTextFormFieldType.email:
                  return EmailFormValidator.validateEmail(email: value ?? "");
                case CustomTextFormFieldType.password:
                  return PasswordFormValidator.validatePassword(
                    password: value ?? "",
                  );
                case CustomTextFormFieldType.phone:
                  return PhoneFormValidator.validatePhone(phone: value ?? "");
                case CustomTextFormFieldType.username:
                  return DefaultFormValidator.validateIsNotEmpty(
                    value: value ?? "",
                  );
                default:
                  return null;
              }
            },
          );
        },
      ),
    );
  }

  TextInputType? _getKeyBoardType({
    required CustomTextFormFieldType textFormFieldType,
  }) {
    switch (textFormFieldType) {
      case CustomTextFormFieldType.email:
        return TextInputType.emailAddress;
      case CustomTextFormFieldType.password:
        return TextInputType.visiblePassword;
      case CustomTextFormFieldType.phone:
        return TextInputType.phone;
      case CustomTextFormFieldType.username:
        return TextInputType.text;
      case CustomTextFormFieldType.cardNumber:
        return TextInputType.number;
      case CustomTextFormFieldType.cvc:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}
