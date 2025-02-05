import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
import 'package:easy_solutions/src/features/presentation/forgot_password_page/View/Components/text_form_field_forgot_email.dart';
import 'package:flutter/material.dart';

//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/alerts/alert_dialog_with_image.dart';
import 'package:provider/provider.dart';

import '../ViewModel/forgot_password_view_model.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> with BaseView {
  // Dependencias
  final ForgotPasswordViewModel _viewModel;

  _ForgotPasswordState({ForgotPasswordViewModel? viewModel})
      : _viewModel = viewModel ?? DefaultForgotPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    _viewModel.initState(
        loadingStateProvider: Provider.of<LoadingStateProvider>(context));

    return SafeArea(
      child: _viewModel.loadingState.isLoading
          ? loadingView
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                leading: backButton(context, Colors.black),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    children: [
                      headerText(
                          text: 'Olvidaste tu contraseña', fontsize: 29.0),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Por favor, ingrese su correo electrónico para recuperar su contraseña.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0),
                        ),
                      ),
                      TextFormFieldEmailResetPassword(
                        viewModel: _viewModel,
                      ),
                      const SizedBox(height: 30.0),
                      createElevatedButton(
                          labelButton: "Enviar",
                          onPressed: () {
                            _ctaButtonTapped(context);
                          })
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

extension UserActions on _ForgotPasswordState {
  void _ctaButtonTapped(BuildContext context) {
    _viewModel.resetPassword().then((value) {
      return showAlertDialogWithImage(
        context,
        const AssetImage('assets/images/forgot_password.png'),
        'Tu contraseña ha sido restablecida',
        'Recibirá un enlace en su correo electrónico para restablecer su contraseña.',
        'Hecho',
        false,
        () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, 'login');
        },
      );
    });
  }
}
