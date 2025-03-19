import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/text_form_fields/custom_text_form_field.dart';
import 'package:easy_solutions/src/features/presentation/login_page/ViewModel/login_view_model.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter/material.dart';
// Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget with BaseView {
  // Dependencias
  final LoginViewModel _viewModel;

  LoginPage({super.key, LoginViewModel? viewModel})
    : _viewModel = viewModel ?? DefaultLoginViewModel();

  @override
  Widget build(BuildContext context) {
    // Inicializar ViewModel
    _viewModel.initState(
      loadingStateProvider: Provider.of<LoadingStateProvider>(context),
    );

    return _viewModel.loadingState.isLoading
        ? loadingView
        : Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: [
                      const Stack(
                        children: [
                          Image(
                            width: double.infinity,
                            height: 300.0,
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/login_back_image.jpg',
                            ),
                          ),
                        ],
                      ),
                      Transform.translate(
                        offset: const Offset(0.0, -20.0),
                        child: Container(
                          width: double.infinity,
                          height: 456,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: Center(
                              child: Form(
                                key: _viewModel.formKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  children: [
                                    headerText(text: '!Bienvenido¡'),
                                    const Text(
                                      'Inicie sesión en su cuenta',
                                      style: TextStyle(
                                        color: grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    CustomTextFormField(
                                      textFormFieldType:
                                          CustomTextFormFieldType.email,
                                      hintext: 'Correo electrónico',
                                      delegate: _viewModel,
                                    ),
                                    CustomTextFormField(
                                      textFormFieldType:
                                          CustomTextFormFieldType.password,
                                      hintext: 'Contraseña',
                                      delegate: _viewModel,
                                    ),
                                    const SizedBox(height: 30.0),
                                    createElevatedButton(
                                      labelButton: 'Inicie Sesión',
                                      onPressed: () {
                                        _ctaButtonTapped(context);
                                      },
                                    ),
                                    const SizedBox(height: 30.0),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          'forgot_password',
                                        );
                                      },
                                      child: const Text(
                                        '¿Olvidaste tu contraseña?',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '¿No tienes cuenta?',
                                          style: TextStyle(
                                            color: grey,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              'sign_up',
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                            ),
                                            child: const Text(
                                              'Registrate',
                                              style: TextStyle(
                                                color: orange,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        );
  }
}

extension UserActions on LoginPage {
  void _ctaButtonTapped(BuildContext context) {
    if (_viewModel.isFormValidate()) {
      _viewModel
          .login(
            email: _viewModel.loginModel?.email ?? "",
            password: _viewModel.loginModel?.password ?? "",
          )
          .then((result) {
            switch (result.status) {
              case ResultStatus.success:
                Provider.of<DefaultUserStateProvider>(
                  context,
                  listen: false,
                ).fetchUserData();
                Navigator.pushNamed(context, "tabs");
              case ResultStatus.error:
                errorStateProvider.setFailure(
                  context: context,
                  value: result.error!,
                );
            }
          });
    }
  }
}
