import 'package:flutter/material.dart';
//Extensions
import 'package:easy_solutions/src/utils/extensions/screen_size.dart';
//Styles
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
//Components
import 'package:easy_solutions/src/features/presentation/payment_methods_page/View/components/empty_payment_methods_view.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final bool emptyPaymentMethodsState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: AppBar(
        elevation: 0.1,
        leading: backButton(context, black),
        backgroundColor: white,
        title: headerText(text: 'Formas de Pago', fontsize: 18.0),
        centerTitle: true,
      ),
      body: emptyPaymentMethodsState
          ? const EmptyPaymentMethodsView()
          : CustomScrollView(slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  _cardContainer(context,
                      cardNumber: '**** 1121',
                      cardAlias: 'Bac Credomatic',
                      isSelected: true),
                  _cardContainer(context,
                      cardNumber: '**** 1254',
                      cardAlias: 'Banco Atlantida',
                      isSelected: false),
                  _buttonAddCardCredit(context),
                ]),
              )
            ]),
    );
  }
}

Widget _cardContainer(BuildContext context,
    {required String cardNumber,
    required String cardAlias,
    required bool isSelected}) {
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
          context: context,
          builder: (context) => _buildBottomSheetContent(context,
              cardNumber: cardNumber,
              cardAlias: cardAlias,
              isSelected: isSelected));
    },
    child: Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      width: screenWidth.getScreenWidth(context: context),
      decoration: createBoxDecorationWithShadows(),
      child: ListTile(
        leading: const Icon(
          Icons.payment,
          size: 30.0,
        ),
        trailing: isSelected
            ? const Icon(
                Icons.check,
                color: Colors.green,
                size: 35.0,
              )
            : const Text(''),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerText(
                text: cardNumber, fontsize: 18.0, textAling: TextAlign.start),
            headerText(text: cardAlias, fontsize: 16.0),
          ],
        ),
      ),
    ),
  );
}

Widget _buildBottomSheetContent(BuildContext context,
    {required String cardNumber,
    required String cardAlias,
    required bool isSelected}) {
  return Container(
    height: screenHeight.getScreenHeight(context: context, multiplier: 0.3),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: headerText(text: cardNumber, fontsize: 18.0),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 0.0, right: 20.0, bottom: 10.0),
                child: headerText(text: cardAlias, fontsize: 16.0),
              ),
            ],
          ),
        ),
        if (!isSelected)
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Usar como tarjeta predeterminada.'),
            onTap: () {},
          ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Eliminar tarjeta'),
          onTap: () {
            _showModalConfirmDelete(context);
          },
        ),
      ],
    ),
  );
}

void _showModalConfirmDelete(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '¿Quierés eliminar esta tarjeta?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              const SizedBox(height: 15.0),
              createElevatedButton(
                  onPressed: () {},
                  labelButton: 'Eliminar tarjeta',
                  backgroundColor: Colors.red),
              const SizedBox(height: 20.0),
              createElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  labelButton: 'Cancelar',
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white)
            ],
          ),
        );
      });
}

Widget _buttonAddCardCredit(BuildContext context) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
      child: createElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'form_add_card_credit');
          },
          height: 45,
          labelButton: 'Agregar tarjeta'));
}
