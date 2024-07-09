import 'package:flutter/material.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
// Styles
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';
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
            title: headerText(text: 'Detalles de Pedido', fontsize: 18.0),
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
                  headerText(text: 'Productos:', fontsize: 25.0),
                  _orders(context),
                  _orders(context),
                  const SizedBox(height: 10.0),
                  _checkoutResume(context),
                  const SizedBox(height: 10.0),
                  headerText(
                      text: 'Dirección: ',
                      fontsize: 25.0,
                      textAling: TextAlign.start),
                  _addressOrder(
                    fullName: 'Ronny Humberto Blandon Martinez',
                    address:
                        'Col. Suyapa, Calle principal, casa rosada a lado de bodega la fe',
                    department: 'La Ceiba',
                    phone: '88956471',
                  ),
                  const SizedBox(height: 20.0),
                  headerText(
                      text: 'Nota Importante: ',
                      fontsize: 25.0,
                      textAling: TextAlign.start),
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
  return headerText(text: 'ID Pedido: #$orderId', fontsize: 25.0);
}

Widget _orderDate({required String orderDate}) {
  return headerText(text: 'Fecha: $orderDate', fontsize: 25.0);
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
      headerText(text: 'Estado: ', fontsize: 25.0, textAling: TextAlign.start),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(30.0)),
        child: headerText(text: orderStatus, color: white, fontsize: 25.0),
      )
    ],
  );
}

Widget _buttonOrderTracking() {
  return SizedBox(
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
            headerText(text: 'Seguimiento', color: white, fontsize: 16.0),
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
    decoration: createBoxDecorationWithShadows(),
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
          child: headerText(text: 'Jaguar King', fontsize: 20.0),
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
          headerText(
              text: 'Pollo frito 8 piezas combo',
              color: orange,
              fontsize: 15.0,
              fontWeight: FontWeight.w400,
              textAling: TextAlign.start),
          headerText(
              text: 'Cantidad: 1',
              color: grey,
              fontsize: 12.0,
              fontWeight: FontWeight.w400,
              textAling: TextAlign.start),
        ],
      ),
      trailing: headerText(
          text: 'L. 455.00',
          color: grey,
          fontsize: 15.0,
          fontWeight: FontWeight.w500),
    ),
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
      title: headerText(
          text: title,
          fontWeight: FontWeight.w500,
          fontsize: 15.0,
          textAling: TextAlign.start),
      trailing: headerText(
          text: value,
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
        headerText(
            text: fullName,
            color: grey,
            fontsize: 14.0,
            fontWeight: FontWeight.w400,
            textAling: TextAlign.start),
        headerText(
            text: address,
            color: grey,
            fontsize: 14.0,
            fontWeight: FontWeight.w400,
            textAling: TextAlign.start),
        headerText(
            text: department,
            color: grey,
            fontsize: 14.0,
            fontWeight: FontWeight.w400,
            textAling: TextAlign.start),
        headerText(
            text: 'Celular: $phone',
            color: grey,
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
    child: headerText(text: text, fontsize: 12.0, fontWeight: FontWeight.w300),
  );
}
