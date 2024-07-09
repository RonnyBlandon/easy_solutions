import 'package:flutter/material.dart';
// Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/button_categories.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        headerText(text: '¿Qué necesitas?'),
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
          onTap: () {
            Navigator.pushNamed(context, 'business_list');
          },
          text: 'SUPER MERCADOS',
          assetsImage: 'assets/images/supermarket_categories.jpg',
          decoration: TextDecoration.underline,
          textColor: Colors.yellow,
        ),
        const SizedBox(height: 20.0),
        ButtonCategories(
          onTap: () {
            Navigator.pushNamed(context, 'business_list');
          },
          text: 'FARMACIAS',
          assetsImage: 'assets/images/pharmacy_categories.jpg',
          decoration: TextDecoration.underline,
          textColor: Colors.yellow,
        ),
        const SizedBox(height: 20.0),
        ButtonCategories(
          onTap: () {
            Navigator.pushNamed(context, 'business_list');
          },
          text: 'FERRETERÍAS',
          assetsImage: 'assets/images/hardware_store_categories.jpg',
          decoration: TextDecoration.underline,
          textColor: Colors.yellow,
        ),
        const SizedBox(height: 20.0),
        ButtonCategories(
          onTap: () {
            Navigator.pushNamed(context, 'business_list');
          },
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
