import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/loading_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/alerts/AlertView/View/alert_dialog.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/menus/ViewModel/menu_view_model.dart';
import 'package:easy_solutions/src/features/presentation/welcome_page/View/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget with BaseView {
  final MenuViewModel _viewModel;

  MainDrawer({super.key, MenuViewModel? viewModel})
    : _viewModel = viewModel ?? DefaultMenuViewModel();

  @override
  Widget build(BuildContext context) {
    // Inicializamos el viewModel
    _viewModel.initState(
      loadingState: Provider.of<LoadingStateProvider>(context),
    );

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/images/logo_easy_solutions.jpg'),
                fit: BoxFit.contain,
              ),
            ),
            child: Text(''),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'profile_details');
            },
            title: const Text('Perfil'),
            leading: const Icon(Icons.person_outline),
          ),
          ListTile(
            onTap: () {
              coordinator.showPaymentMethodsPage(context: context);
            },
            title: const Text('Formas de pago'),
            leading: const Icon(Icons.payment),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'legal_info');
            },
            title: const Text('Información legal'),
            leading: const Icon(Icons.info_outline),
          ),
          ListTile(
            onTap: () {
              _signOut(context);
            },
            title: const Text('Cerrar Sesión'),
            leading: const Icon(Icons.exit_to_app),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
            child: Text('Versión 1.0', textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '\u00A9 2025 Desarrollado por ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: 'Ronny Blandón',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: const Image(
              height: 16.0,
              image: AssetImage('assets/images/linkedin_ronny.png'),
            ),
            onTap: () {
              String urlString = 'https://www.linkedin.com/in/ronnyblandon/';
              Uri url = Uri.parse(urlString);
              launchUrl(url);
            },
          ),
        ],
      ),
    );
  }
}

extension UserActions on MainDrawer {
  Future<void> _signOut(BuildContext context) async {
    AlertView.showAlertDialog(
      context: context,
      imagePath: const AssetImage('assets/images/logout.png'),
      headerTitle: "Cierre de Sesión en curso",
      headerSubTitle: "¿Desea salir de la sesión?",
      labelButton: "Cerrar Sesión",
      isDismissible: true,
      doneButtonFunc: () {
        _viewModel.signOut().then((_) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(pageBuilder: (_, __, ___) => const WelcomePage()),
          );
        });
      },
    );
  }
}
