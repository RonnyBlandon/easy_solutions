import 'package:flutter/material.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const Text(''),
            backgroundColor: white,
            title: customTitle('Mis Pedidos', Colors.black, fontsize: 18.0),
            centerTitle: true,
          ),
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
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromRGBO(248, 248, 248, 1.0),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(210, 211, 215, 1.0),
              spreadRadius: 1.0,
              blurRadius: 4.0)
        ]),
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
    child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTitle('Pollo frito 8 piezas combo', orange,
              fontsize: 15.0,
              fontWeight: FontWeight.w400,
              textAling: TextAlign.start),
          customTitle('Con tajadas de guineo, repollo, caldo y aderezo.', grey,
              fontsize: 12.0,
              fontWeight: FontWeight.w400,
              textAling: TextAlign.start),
        ],
      ),
      trailing: customTitle('L. 455.00', grey,
          fontsize: 15.0, fontWeight: FontWeight.w500),
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
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: white,
      boxShadow: const [
        BoxShadow(
            color: Color.fromRGBO(210, 211, 215, 1.0),
            spreadRadius: 1.0,
            blurRadius: 4.0)
      ],
    ),
    child: Column(
      children: [
        _itemsCheckOutResume(
            context: context, title: 'Subtotal', value: 'L. 455.00'),
        _itemsCheckOutResume(
            context: context, title: 'Envío', value: 'L. 50.00'),
        _itemsCheckOutResume(
            context: context, title: 'Total', value: 'L. 59.35'),
        _buttonCheckout(),
      ],
    ),
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
