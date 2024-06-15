import 'package:flutter/material.dart';

//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/menus/main_app_bar.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: MainAppBar(actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'shopping_cart');
                },
                icon: const Icon(
                  Icons.shopping_cart,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                )),
          ])),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Elige tu restaurante:',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            _gridRestaurantList(context),
          ],
        ),
      ),
    );
  }
}

Widget _gridRestaurantList(BuildContext context) {
  return Expanded(
      child: GridView.count(
    crossAxisCount: 3,
    children: List.generate(20, (index) {
      return _cardRestaurant(context);
    }),
  ));
}

Widget _cardRestaurant(BuildContext context) {
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'restaurant_menu');
        },
        child: Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(3.0, 3.0), // Desplazamiento de la sombra
                  blurRadius: 4.0, // Difuminación de la sombra
                )
              ],
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/images/restaurants/logos/jaguar_logo.png'))),
        ),
      ),
      const Text(
        'Jaguar King',
        style: TextStyle(
            color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
      )
    ],
  );
}
