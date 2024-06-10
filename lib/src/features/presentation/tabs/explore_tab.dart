import 'package:flutter/material.dart';
// Colors
import 'package:easy_solutions/src/colors/colors.dart';
// Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/button_categories.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        customTitle('¿Qué necesitas?', Colors.black),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    //_topBar(),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const SizedBox(),
                    _scrollCategories(context),
                    //_sliderCards()
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

Widget _scrollCategories(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
    child: Column(
      children: [
        ButtonCategories(
          onTap: () {
            Navigator.pushNamed(context, 'restaurant_list');
          },
          text: 'RESTAURANTES',
          assetsImage: 'assets/images/restaurant_categories.png',
          decoration: TextDecoration.underline,
          textColor: Colors.yellow,
        ),
        const SizedBox(height: 20.0),
        ButtonCategories(
          onTap: () {},
          text: 'SUPER MERCADOS',
          assetsImage: 'assets/images/supermarket_categories.jpg',
          decoration: TextDecoration.underline,
          textColor: Colors.yellow,
        ),
        const SizedBox(height: 20.0),
        ButtonCategories(
          onTap: () {},
          text: 'FARMACIAS',
          assetsImage: 'assets/images/pharmacy_categories.jpg',
          decoration: TextDecoration.underline,
          textColor: Colors.yellow,
        ),
        const SizedBox(height: 20.0),
        ButtonCategories(
          onTap: () {},
          text: 'FERRETERÍAS',
          assetsImage: 'assets/images/hardware_store_categories.jpg',
          decoration: TextDecoration.underline,
          textColor: Colors.yellow,
        ),
        const SizedBox(height: 20.0),
        ButtonCategories(
          onTap: () {},
          text: 'FLORISTERÍAS',
          assetsImage: 'assets/images/florist_categories.jpg',
          decoration: TextDecoration.underline,
          textColor: Colors.yellow,
        ),
        const SizedBox(height: 20.0)
      ],
    ),
  );
}

Widget _topBar() {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Row(
      children: [
        Container(
          width: 280.0,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(left: 15.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0)),
          child: const Row(
            children: [
              Icon(
                Icons.search,
                size: 20.0,
              ),
              Text('  Buscar', style: TextStyle(color: grey, fontSize: 17.0))
            ],
          ),
        ),
        Container(
          width: 40.0,
          height: 40.0,
          margin: const EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(30.0)),
          child: const IconButton(
              icon: Icon(
                Icons.filter_list,
                size: 25.0,
                color: Colors.white,
              ),
              onPressed: null),
        )
      ],
    ),
  );
}

Widget _sliderCards() {
  return SizedBox(
    height: 400.0,
    child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return _card(context);
        }),
  );
}

Widget _card(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: const Image(
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: const Text(
                'Ensalada proteica',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ),
            const Text(
              'Huevo y carne juntos',
              style: TextStyle(
                  color: Color.fromARGB(255, 209, 192, 192),
                  fontWeight: FontWeight.normal,
                  fontSize: 13.0),
            )
          ],
        ),
      ],
    ),
  );
}
