import 'package:flutter/material.dart';
//Components
import 'package:easy_solutions/src/features/presentation/shopping_cart_page/View/components/empty_shopping_cart_view.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
//Styles
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final bool emptyShoppingCartState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: customTitle('Carrito', Colors.black, fontsize: 18.0),
        centerTitle: true,
      ),
      body: emptyShoppingCartState
          ? const EmptyShoppingCartView()
          : CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _orders(context),
                        _orders(context),
                        const SizedBox(height: 20.0),
                        _checkoutResume(context),
                      ],
                    ),
                  )
                ]))
              ],
            ),
    );
  }
}

Widget _orders(BuildContext context) {
  return Column(
    children: [
      _cardOrders(context),
    ],
  );
}

Widget _cardOrders(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    width: double.infinity,
    decoration: createBoxDecorationWithShadows(
        borderRadius: BorderRadius.circular(10.0)),
    child: Column(
      children: [
        _cardOrderTopContent(),
        _items(context),
        _items(context),
        _moreContent(context),
      ],
    ),
  );
}

Widget _cardOrderTopContent() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    width: double.infinity,
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20.0),
          child: customTitle('Jaguar King', Colors.black, fontsize: 20.0),
        ),
      ],
    ),
  );
}

Widget _items(context) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: grey)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            const Image(
                width: 60.0,
                height: 60.0,
                image: AssetImage(
                    'assets/images/restaurants/menu_images/pollo_frito.jpg')),
            Expanded(
              child: customTitle('Pollo frito 8 piezas combo', orange,
                  fontsize: 16.0, fontWeight: FontWeight.w400),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete_forever))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customTitle('L. 455.00', red, fontsize: 18.0),
            _cartItemQuantity(),
          ],
        )
      ],
    ),
  );
}

Widget _moreContent(BuildContext context) {
  return ListTile(
    title: customTitle('Añadir más', pink,
        fontWeight: FontWeight.w600, fontsize: 17.0),
  );
}

Widget _checkoutResume(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    width: double.infinity,
    decoration: createBoxDecorationWithShadows(
        borderRadius: BorderRadius.circular(10.0)),
    child: Column(
      children: [
        _itemsCheckOutResume(
            context: context, title: 'Subtotal', value: 'L. 395.65'),
        _itemsCheckOutResume(
            context: context, title: 'Impuestos', value: 'L. 59.35'),
        _itemsCheckOutResume(
            context: context, title: 'Envío', value: 'L. 50.00'),
        _buttonCheckout(),
      ],
    ),
  );
}

Widget _cartItemQuantity() {
  return Row(
    children: [
      IconButton(
          onPressed: () {}, icon: const Icon(Icons.remove_circle_outline)),
      customTitle('Cantidad: 1', black,
          fontsize: 14.0, fontWeight: FontWeight.w300),
      IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
    ],
  );
}

Widget _itemsCheckOutResume(
    {context = BuildContext, title = String, value = String}) {
  return Container(
    decoration: const BoxDecoration(
        border: Border(
      bottom: BorderSide(color: grey),
    )),
    child: ListTile(
      title: customTitle(title, Colors.black,
          fontWeight: FontWeight.w500,
          fontsize: 15.0,
          textAling: TextAlign.start),
      trailing: customTitle(value, Colors.black,
          fontWeight: FontWeight.w500,
          fontsize: 15.0,
          textAling: TextAlign.start),
    ),
  );
}

Widget _buttonCheckout() {
  return Container(
    width: double.infinity,
    height: 45.0,
    margin: const EdgeInsets.only(top: 10.0),
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: orange,
        foregroundColor: white,
        overlayColor: Colors.black,
      ),
      child: Row(
        children: [
          customTitle('Continuar', white, fontsize: 17.0),
          const Spacer(),
          customTitle('L. 505.00', white, fontsize: 15.0),
        ],
      ),
    ),
  );
}
