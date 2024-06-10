import 'package:flutter/material.dart';

class AddressesTab extends StatefulWidget {
  const AddressesTab({super.key});

  @override
  State<AddressesTab> createState() => _AddressesTabState();
}

class _AddressesTabState extends State<AddressesTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Direcciones'));
  }
}
