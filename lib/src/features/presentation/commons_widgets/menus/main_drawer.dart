import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
                )),
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
                Navigator.pushNamed(context, 'payment_methods');
              },
              title: const Text('Formas de pago'),
              leading: const Icon(Icons.payment)),
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'legal_info');
              },
              title: Text('Información legal'),
              leading: Icon(Icons.info_outline)),
          const ListTile(
              title: Text('Cerrar Sesión'), leading: Icon(Icons.exit_to_app)),
          const Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
            child: Text(
              'Versión 1.0',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(children: [
                TextSpan(
                  text: '\u00A9 2024 Desarrollado por ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal),
                ),
                TextSpan(
                    text: 'Ronny Blandón',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)),
              ]),
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
          )
        ],
      ),
    );
  }
}
