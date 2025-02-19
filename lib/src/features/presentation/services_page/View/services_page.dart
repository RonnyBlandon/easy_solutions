import 'package:flutter/material.dart';

//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/menus/main_app_bar.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/menus/main_drawer.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/button_categories.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MainAppBar(actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(context, 'notifications'),
                icon: const Icon(
                  Icons.notifications,
                )),
          ])),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: const Text(
              '¡Hola Ronny Blandon!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: const Text(
              'Elige tu servicio:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate(
                    [
                      ButtonCategories(
                        onTap: () {
                          Navigator.pushNamed(context, 'tabs');
                        },
                        text: 'ENTREGA A DOMICILIO',
                        networkImage: 'assets/images/delivery_service.jpg',
                        height: 220.0,
                        marginBottom: 20.0,
                        fontSize: 28.0,
                        textBackgroundColor: Colors.orange,
                      ),
                      const SizedBox(height: 120.0),
                      const Text('Próximamente, más servicios en camino...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      const Image(
                          width: 120.0,
                          height: 120.0,
                          image: AssetImage('assets/images/gif/tools.gif'))
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
