import 'package:flutter/material.dart';
//Extension
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
//Third party package
import 'package:another_carousel_pro/another_carousel_pro.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: backButton(context, Colors.black),
          title: customTitle('Pollo frito 8 piezas combo', Colors.black,
              fontsize: 18.0),
          actions: [
            IconButton(
                onPressed: () {},
                color: Colors.black,
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: CustomScrollView(slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            _productInfo(context),
            Container(
                color: Colors.white,
                child: _productInfoContainer(
                  productName: 'Pollo frito 8 piezas combo',
                  productDescription:
                      'Con tajadas de guineo, repollo, caldo y aderezo.',
                  productPrice: 'L. 455.00',
                  productProvider: 'Jaguar King',
                )),
          ]))
        ]),
        bottomNavigationBar: _addCart(context),
      ),
    );
  }
}

Widget _productInfo(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: screenHeight.getScreenHeight(
                context: context, multiplier: 0.35),
            child: AnotherCarousel(
                dotSize: 7.0,
                indicatorBgPadding: 5.0,
                images: const [
                  AssetImage(
                      'assets/images/restaurants/menu_images/pollo_frito.jpg'),
                  AssetImage(
                      'assets/images/restaurants/menu_images/pollo_frito2.jpg'),
                ]),
          ),
        ],
      ),
    ],
  );
}

Widget _productInfoContainer(
    {required String productName,
    required String productDescription,
    required String productPrice,
    required String productProvider}) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 12.0, left: 15.0, bottom: 15.0, right: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customTitle(productName, Colors.black, fontsize: 21.0),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customTitle(productPrice, Colors.green, fontsize: 24.0),
            IconButton(
                onPressed: () {},
                iconSize: 30.0,
                icon: const Icon(Icons.favorite_border))
          ],
        ),
        const SizedBox(height: 10.0),
        customTitle('Descripción y Especificaciones', Colors.black,
            fontsize: 20.0, fontWeight: FontWeight.w500),
        const SizedBox(height: 5.0),
        customTitle('-', Colors.black, fontWeight: FontWeight.w400),
        const SizedBox(height: 5.0),
        customTitle(
          productDescription,
          Colors.black,
          fontsize: 16.0,
          fontWeight: FontWeight.w400,
          textAling: TextAlign.start,
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customTitle('Proveedor', Colors.black,
                fontsize: 16.0, fontWeight: FontWeight.w400),
            const Text('-'),
            customTitle(productProvider, Colors.black,
                fontsize: 16.0, fontWeight: FontWeight.w400),
          ],
        )
      ],
    ),
  );
}

Widget _addCart(BuildContext context) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.remove)),
              customTitle(' 1 ', Colors.black, fontsize: 16.0),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ],
          ),
        ),
        createElevatedButton(
            onPressed: () {},
            width:
                screenWidth.getScreenWidth(context: context, multiplier: 0.5),
            height: 49.0,
            radius: 10.0,
            backgroundColor: Colors.blue,
            labelButton: 'Agregar'),
      ],
    ),
  );
}
