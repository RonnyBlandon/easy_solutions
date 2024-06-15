import 'dart:ui';
import 'package:flutter/material.dart';

//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';

class RestaurantMenuPage extends StatelessWidget {
  const RestaurantMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverAppBar(
            backgroundColor: Colors.blue,
            expandedHeight: 265.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  color: Colors.white, child: _restaurantProfile(context)),
            ),
            leading: backButton(context, Colors.white),
            actions: [
              IconButton(
                onPressed: () {},
                color: Colors.white,
                icon: const Icon(Icons.favorite, size: 28.0),
              ),
              const SizedBox(width: 10.0),
              IconButton(
                onPressed: () {},
                color: Colors.white,
                icon: const Icon(Icons.more_vert, size: 28.0),
              ),
              const SizedBox(width: 10.0)
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            //Container(color: Colors.white, child: _restaurantProfile(context)),
            Container(
                color: Colors.white, child: _restaurantMenuContainer(context)),
          ]))
        ]),
      ),
    );
  }
}

Widget _restaurantProfile(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        children: [
          Container(
            height: 200.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/welcome_image.jpg'),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            bottom: 0.0,
            child: Container(
              width: 65.0,
              height: 65.0,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/restaurants/logos/jaguar_logo.png')),
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          )
        ],
      ),
      _restaurantInfo()
    ],
  );
}

Widget _restaurantInfo() {
  return Container(
    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jaguar King',
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0)),
              child: const Text(
                'Abierto',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            const Text(
              'Horario 10:00 am - 8:00 pm',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _restaurantMenuContainer(BuildContext context) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 12.0, left: 15.0, bottom: 15.0, right: 15.0),
    child: Column(
      children: [
        const Text(
          'Menú',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext context, index) {
            return _listMenuCategories(context);
          },
        ),
      ],
    ),
  );
}

Widget _listMenuCategories(BuildContext context) {
  return Container(
    color: Colors.grey,
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: const Text(
            'Pollos en combo',
            style: TextStyle(
                color: Colors.amber,
                backgroundColor: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        _listmenuProduct(context),
      ],
    ),
  );
}

Widget _listmenuProduct(BuildContext context) {
  return Column(
    children: [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context, index) {
          return _cardProduct(context);
        },
      ),
    ],
  );
}

Widget _cardProduct(BuildContext context) {
  return Container(
    width: double.infinity,
    color: Colors.grey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey))),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'menu_details');
                },
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: const Image(
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/images/restaurants/menu_images/pollo_frito.jpg')),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pollo frito 8 piezas combo',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text('Con tajadas de guineo repollo, caldo y aderezo.')
                      ],
                    ),
                  )
                ]),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border)),
                  const Spacer(),
                  const Text(
                    'L. 455.00',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
