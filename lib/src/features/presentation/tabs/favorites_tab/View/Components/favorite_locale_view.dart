import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
// Styles
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';

class FavoriteLocaleView extends StatefulWidget {
  const FavoriteLocaleView({super.key});

  @override
  State<FavoriteLocaleView> createState() => _FavoriteLocaleViewState();
}

class _FavoriteLocaleViewState extends State<FavoriteLocaleView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  _cardFavorite(context),
                  _cardFavorite(context),
                  _cardFavorite(context)
                ],
              ),
            )
          ]),
        ),
      ],
    );
  }
}

Widget _cardFavorite(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, 'restaurant_menu');
    },
    child: Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: createBoxDecorationWithShadows(
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          const Image(
              width: 50.0,
              height: 50.0,
              image: AssetImage(
                  'assets/images/restaurants/logos/jaguar_logo.png')),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerText(
                  text: 'Jaguar King',
                  color: black,
                  fontsize: 16.0,
                  fontWeight: FontWeight.w500),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: green, borderRadius: BorderRadius.circular(10.0)),
                child:
                    headerText(text: 'Abierto', color: white, fontsize: 14.0),
              )
            ],
          ),
          const Spacer(),
          IconButton(
            color: Colors.red,
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          )
        ],
      ),
    ),
  );
}
