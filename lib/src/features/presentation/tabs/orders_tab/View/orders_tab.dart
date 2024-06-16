import 'package:flutter/material.dart';
//Components
import 'package:easy_solutions/src/features/presentation/tabs/orders_tab/View/components/empty_order_view.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final bool emptyOrderState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      body: emptyOrderState
          ? const EmptyOrderView()
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: const Text(''),
                  backgroundColor: white,
                  title:
                      customTitle('Mis Pedidos', Colors.black, fontsize: 18.0),
                  centerTitle: true,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          _order(
                            context,
                            orderDate: '16/06/2024',
                            orderId: '1005',
                            orderTotal: '505.00',
                            orderStatus: 'Pendiente',
                          ),
                          _order(
                            context,
                            orderDate: '15/06/2024',
                            orderId: '1004',
                            orderTotal: '578.00',
                            orderStatus: 'Entregado',
                          ),
                          _order(
                            context,
                            orderDate: '14/06/2024',
                            orderId: '1003',
                            orderTotal: '608.00',
                            orderStatus: 'Entregado',
                          ),
                          _order(
                            context,
                            orderDate: '13/06/2024',
                            orderId: '1002',
                            orderTotal: '441.00',
                            orderStatus: 'Cancelado',
                          ),
                          _order(
                            context,
                            orderDate: '12/06/2024',
                            orderId: '1001',
                            orderTotal: '638.50',
                            orderStatus: 'Entregado',
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            ),
    );
  }
}

final Map<String, Color> _orderStatusToColorMap = {
  "Pendiente": Colors.blue,
  "Entregado": Colors.green,
  "Cancelado": Colors.red,
};

Widget _order(BuildContext context,
    {required String orderDate,
    required String orderId,
    required String orderTotal,
    required String orderStatus}) {
  final Color color = _orderStatusToColorMap[orderStatus] ?? Colors.grey;

  return Container(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.only(bottom: 20.0),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTitle('Fecha: $orderDate', black, fontsize: 16.0),
            customTitle('ID: $orderId', black, fontsize: 16.0),
            customTitle('Total: L. $orderTotal', black, fontsize: 16.0),
            Row(
              children: [
                customTitle('Estado: ', black, fontsize: 16.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  margin: const EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(20.0)),
                  child: customTitle(orderStatus, white, fontsize: 16.0),
                )
              ],
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'order_details');
            },
            color: Colors.green,
            iconSize: 40.0,
            icon: const Icon(Icons.remove_red_eye)),
      ],
    ),
  );
}
