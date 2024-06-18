import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';

class FavoriteProductView extends StatefulWidget {
  const FavoriteProductView({super.key});

  @override
  State<FavoriteProductView> createState() => _FavoriteProductViewState();
}

class _FavoriteProductViewState extends State<FavoriteProductView> {
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
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'restaurant_menu');
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(210, 211, 215, 1.0),
                    spreadRadius: 1.0,
                    blurRadius: 4.0)
              ]),
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
                  customTitle('Jaguar King', black,
                      fontsize: 16.0, fontWeight: FontWeight.w500),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: customTitle('Abierto', white, fontsize: 14.0),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      _sliderProducts(context),
    ],
  );
}

Widget _sliderProducts(BuildContext context) {
  return Container(
    height: 200.0,
    margin: const EdgeInsets.only(bottom: 25.0),
    child: ListView.builder(
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, index) {
        return _cardProduct(context);
      },
    ),
  );
}

Widget _cardProduct(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, 'menu_details');
    },
    child: Container(
      width: 180.0,
      margin: const EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
          border: Border.all(color: black),
          borderRadius: BorderRadius.circular(10.0)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: const Image(
                width: double.infinity,
                height: 120.0,
                fit: BoxFit.cover,
                image: AssetImage(
                    'assets/images/restaurants/menu_images/pollo_frito.jpg')),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: const Text(
              'Pollo frito 8 piezas combo',
              style: TextStyle(
                  color: black, fontSize: 13.0, fontWeight: FontWeight.w400),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customTitle('L. 455.00', black, fontsize: 14.0),
                IconButton(
                    color: Colors.red,
                    onPressed: () {},
                    icon: const Icon(Icons.favorite)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
