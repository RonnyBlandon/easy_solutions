import 'dart:async';
import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/colors/colors.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/alerts/AlertView/View/alert_dialog.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/profile/EditPasswordPage/ViewModel/edit_password_view_model.dart';
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> with BaseView {
  final EditPasswordViewModel _viewModel;
  bool _isButtonDisabled = false;

  _EditPasswordPageState({EditPasswordViewModel? viewModel})
    : _viewModel = viewModel ?? DefaultEditPasswordViewModel();

  @override
  Widget build(BuildContext context) {
    _viewModel.initState(
      loadingStateProvider: Provider.of<LoadingStateProvider>(context),
    );

    return Scaffold(
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(text: 'Cambiar contraseña', fontsize: 18.0),
        centerTitle: true,
      ),
      body:
          (context).isLoading()
              ? loadingView
              : CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 16),
                      Container(
                        decoration: getBoxDecorationWithShadows(),
                        width: getScreenWidth(context: context),
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              "Recibirás un enlace para crear una nueva contraseña por correo electrónico.",
                              style: const TextStyle(
                                fontSize: 15,
                                color: accentColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              initialValue: (context).getUserData()?.email,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            createElevatedButton(
                              labelButton: 'Enviar',
                              onPressed:
                                  _isButtonDisabled
                                      ? null
                                      : () {
                                        _ctaButtonTapped(context);
                                      },
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
    );
  }

  void _ctaButtonTapped(BuildContext context) {
    setState(() {
      _isButtonDisabled = true;
    });

    _viewModel.email = (context).getUserData()?.email ?? "";
    _viewModel.resetPassword().then((value) {
      AlertView.showAlertDialog(
        context: context,
        imagePath: const AssetImage('assets/images/forgot_password.png'),
        headerTitle: 'Enlace enviado',
        headerSubTitle:
            'Te hemos enviado un enlace a tu correo para restablecer tu contraseña. Por seguridad, este enlace será válido solo por 15 minutos. Si no lo usas a tiempo, deberás solicitar uno nuevo.',
        labelButton: 'Hecho',
        isDismissible: false,
        doneButtonFunc: () {
          AlertView.closeAlertDialog(context);
        },
      );
    });

    Timer(const Duration(minutes: 1), () {
      setState(() {
        _isButtonDisabled = false;
      });
    });
  }
}
