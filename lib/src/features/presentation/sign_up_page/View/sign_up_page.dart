import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/text_form_fields/custom_text_form_field.dart';
import 'package:easy_solutions/src/features/presentation/sign_up_page/ViewModel/sign_up_view_model.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Colors
import 'package:easy_solutions/src/colors/colors.dart';

//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';

class SignUpPage extends StatelessWidget with BaseView {
  final SignUpViewModel _viewModel;
  SignUpPage({super.key, SignUpViewModel? viewModel})
      : _viewModel = viewModel ?? DefaultSignUpViewModel();

  @override
  Widget build(BuildContext context) {
    _viewModel.initState(
        loadingStateProvider: Provider.of<LoadingStateProvider>(context));

    return _viewModel.loadingState.isLoading
        ? loadingView
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: backButton(context, Colors.black),
            ),
            body: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Center(
                      child: Form(
                    key: _viewModel.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      child: Column(
                        children: [
                          headerText(text: 'Crea una cuenta', color: black),
                          CustomTextFormField(
                              textFormFieldType:
                                  CustomTextFormFieldType.username,
                              hintext: 'Nombre Completo',
                              delegate: _viewModel),
                          CustomTextFormField(
                              textFormFieldType: CustomTextFormFieldType.email,
                              hintext: 'Correo electrónico',
                              delegate: _viewModel),
                          CustomTextFormField(
                              textFormFieldType: CustomTextFormFieldType.phone,
                              hintext: 'Telefono',
                              delegate: _viewModel),
                          CustomTextFormField(
                              textFormFieldType:
                                  CustomTextFormFieldType.password,
                              hintext: 'Contraseña',
                              delegate: _viewModel),
                          const SizedBox(
                            height: 25.0,
                          ),
                          createElevatedButton(
                              onPressed: () {
                                _ctaTapped(context);
                              },
                              labelButton: 'Registrarse'),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text:
                                        'Al hacer clic en Registrarse aceptas los siguientes',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15.0),
                                  ),
                                  TextSpan(
                                    text: ' Términos y Condiciones',
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(context, 'welcome');
                                      },
                                  ),
                                  const TextSpan(
                                    text: ' sin reservas.',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ]))
              ],
            ));
  }
}

extension UserActions on SignUpPage {
  void _ctaTapped(BuildContext context) {
    if (_viewModel.isFormValidate()) {
      _viewModel.signUp().then((result) {
        switch (result.status) {
          case ResultStatus.success:
            Navigator.pushNamed(context, "tabs");
          case ResultStatus.error:
            errorStateProvider.setFailure(
                context: context, value: result.error!);
        }
      });
    }
  }
}
