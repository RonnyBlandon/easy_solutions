import 'package:flutter/material.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/menus/main_app_bar.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
//Styles
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';
//Extensions
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';

class BusinessListPage extends StatefulWidget {
  const BusinessListPage({super.key});

  @override
  State<BusinessListPage> createState() => _BusinessListPageState();
}

class _BusinessListPageState extends State<BusinessListPage> {
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
              'Elige el establecimiento:',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            _businessList(context),
          ],
        ),
      ),
    );
  }
}

Widget _businessList(BuildContext context) {
  return SizedBox(
    height: screenHeight.getScreenHeight(context: context, multiplier: 0.84),
    child: ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, index) {
        return _cardBusinnes();
      },
    ),
  );
}

Widget _cardBusinnes() {
  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.all(10.0),
    decoration: createBoxDecorationWithShadows(
        borderRadius: BorderRadius.circular(10.0)),
    child: Row(
      children: [
        const Image(
            width: 80.0,
            height: 80.0,
            image: AssetImage('assets/images/business/logo_business.png')),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTitle(
              'Jaguar King',
              Colors.black,
              fontsize: 18.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30.0)),
              child: customTitle('Abierto', Colors.white, fontsize: 16.0),
            )
          ],
        )
      ],
    ),
  );
}
