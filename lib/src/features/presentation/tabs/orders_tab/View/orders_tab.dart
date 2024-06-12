import 'package:flutter/material.dart';
//Components
import 'package:easy_solutions/src/features/presentation/tabs/orders_tab/View/components/empty_order_view.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final bool emptyOrderState = true;

  @override
  Widget build(BuildContext context) {
    return emptyOrderState ? const EmptyOrderView() : const Text('Order View');
  }
}
