import 'dart:ui';
import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/welcome_page/ViewModel/welcome_page_view_model.dart';
import 'package:easy_solutions/src/utils/Helpers/ResultType/result_type.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with BaseView {
  final WelcomePageViewModel viewModel;

  _WelcomePageState({WelcomePageViewModel? welcomePageViewModel})
      : viewModel = welcomePageViewModel ?? DefaultWelcomePageViewModel();

  @override
  Widget build(BuildContext context) {
    viewModel.initState(
        loadingStateProvider: Provider.of<LoadingStateProvider>(context));

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                  'assets/images/welcome_image.jpg'), // Paréntesis de cierre añadido
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              color: Colors.black.withValues(),
            ),
          ),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: headerText(
                  text: 'ENTREGAS A DOMICILIO HASTA LA PUERTA DE TU CASA',
                  color: white)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              'Proporcione su ubicación exacta para encontrar los servicios de entrega más adecuados cerca de usted',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  decoration: TextDecoration.none),
            ),
          ),
          createElevatedButton(
              isWithIcon: false,
              labelButton: 'Iniciar Sesión',
              onPressed: () {
                Navigator.pushNamed(context, 'login');
              }),
          const SizedBox(height: 20),
          createElevatedButton(
              isWithIcon: true,
              icon: const AssetImage('assets/images/google_icono.png'),
              labelButton: 'Iniciar Sesión con Google',
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              onPressed: () {
                _googleSignInTapped(context);
              })
        ]),
      ],
    );
  }
}

extension UserActions on _WelcomePageState {
  _googleSignInTapped(BuildContext context) {
    viewModel.signInWithGoogle().then((result) {
      switch (result.status) {
        case ResultStatus.success:
          coordinator.showTabsPage(context: context);
        case ResultStatus.error:
          errorStateProvider.setFailure(context: context, value: result.error!);
      }
    });
  }
}
