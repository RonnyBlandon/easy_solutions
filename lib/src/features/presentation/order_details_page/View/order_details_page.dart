import 'package:flutter/material.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            leading: backButton(context, black),
            backgroundColor: white,
            title:
                customTitle('Detalles de Pedido', Colors.black, fontsize: 18.0),
            centerTitle: true,
          )),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  _orderId(orderId: '1001'),
                  const SizedBox(height: 10.0),
                  _orderStatus(orderStatus: 'Entregado'),
                  const SizedBox(height: 10.0),
                  _orderDate(orderDate: '16/06/2024'),
                  const SizedBox(height: 10.0),
                  _buttonOrderTracking(),
                  const SizedBox(height: 10.0),
                  customTitle('Productos:', black, fontsize: 25.0),
                  _orders(context),
                  _orders(context),
                  const SizedBox(height: 10.0),
                  _checkoutResume(context),
                  const SizedBox(height: 10.0),
                  customTitle('Dirección: ', black,
                      fontsize: 25.0, textAling: TextAlign.start),
                  _addressOrder(
                    fullName: 'Ronny Humberto Blandon Martinez',
                    address:
                        'Col. Suyapa, Calle principal, casa rosada a lado de bodega la fe',
                    department: 'La Ceiba',
                    phone: '88956471',
                  ),
                  const SizedBox(height: 20.0),
                  customTitle('Nota Importante: ', black,
                      fontsize: 25.0, textAling: TextAlign.start),
                  _importantNote(),
                  const SizedBox(height: 10.0),
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}

Widget _orderId({required String orderId}) {
  return customTitle('ID Pedido: #$orderId', black, fontsize: 25.0);
}

Widget _orderDate({required String orderDate}) {
  return customTitle('Fecha: $orderDate', black, fontsize: 25.0);
}

final Map<String, Color> _orderStatusToColorMap = {
  "Pendiente": Colors.blue,
  "Entregado": Colors.green,
  "Cancelado": Colors.red,
};

Widget _orderStatus({required String orderStatus}) {
  final Color color = _orderStatusToColorMap[orderStatus] ?? Colors.grey;

  return Row(
    children: [
      customTitle('Estado: ', black,
          fontsize: 25.0, textAling: TextAlign.start),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30.0)),
        child: customTitle(orderStatus, white, fontsize: 25.0),
      )
    ],
  );
}

Widget _buttonOrderTracking() {
  return Container(
    width: 200.0,
    child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: orange,
          overlayColor: black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customTitle('Seguimiento', white, fontsize: 16.0),
            const SizedBox(width: 10.0),
            const Icon(
              Icons.arrow_forward,
              color: white,
            )
          ],
        )),
  );
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
          customTitle('Cantidad: 1', grey,
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
            context: context, title: 'Subtotal', value: 'L. 395.65'),
        _itemsCheckOutResume(
            context: context, title: 'Impuesto', value: 'L. 59.35'),
        _itemsCheckOutResume(
            context: context, title: 'Envío', value: 'L. 50.00'),
        _itemsCheckOutResume(
            context: context, title: 'Total', value: 'L. 505.00'),
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

Widget _addressOrder({
  required String fullName,
  required String address,
  required String department,
  required String phone,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(left: 10.0),
    decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: grey)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customTitle(fullName, grey,
            fontsize: 14.0,
            fontWeight: FontWeight.w400,
            textAling: TextAlign.start),
        customTitle(address, grey,
            fontsize: 14.0,
            fontWeight: FontWeight.w400,
            textAling: TextAlign.start),
        customTitle(department, grey,
            fontsize: 14.0,
            fontWeight: FontWeight.w400,
            textAling: TextAlign.start),
        customTitle('Celular: $phone', grey,
            fontsize: 14.0,
            fontWeight: FontWeight.w400,
            textAling: TextAlign.start),
      ],
    ),
  );
}

Widget _importantNote({String text = ''}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: grey)),
    child:
        customTitle(text, black, fontsize: 12.0, fontWeight: FontWeight.w300),
  );
}
