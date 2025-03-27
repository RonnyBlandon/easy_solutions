import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/PaymentMethods/payment_methods_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/alerts/AlertView/View/alert_dialog.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/utils/Helpers/Checkout/checkout_helper.dart';
import 'package:easy_solutions/src/utils/Helpers/ScreenSize/screen_size_helper.dart';
import 'package:easy_solutions/src/utils/styles/box_decoration_shadows.dart';
import 'package:flutter/material.dart';

class PaymentMethodsContentView extends StatefulWidget {
  final List<PaymentMethodEntity> paymentMethodList;
  final BaseViewStateDelegate? delegate;
  const PaymentMethodsContentView({
    super.key,
    required this.paymentMethodList,
    required this.delegate,
  });

  @override
  State<PaymentMethodsContentView> createState() =>
      _PaymentMethodsContentViewState();
}

class _PaymentMethodsContentViewState extends State<PaymentMethodsContentView>
    with BaseView {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.paymentMethodList.length,
            itemBuilder: (BuildContext context, index) {
              final paymentMethod = widget.paymentMethodList[index];
              return _cardPaymentMethod(context, paymentMethod: paymentMethod);
            },
          ),
        ),
        _buttonAddCardCredit(context, delegate: widget.delegate),
      ],
    );
  }

  _pop(BuildContext context) {
    widget.delegate?.onChange();
    Navigator.pop(context);
  }

  Widget _cardPaymentMethod(
    BuildContext context, {
    required PaymentMethodEntity paymentMethod,
  }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder:
              (context) => _buildBottomSheetContent(
                context,
                paymentMethod: paymentMethod,
              ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        width: getScreenWidth(context: context),
        decoration:
            paymentMethod.isMainPaymentMethod
                ? createBoxDecorationWithShadows(containerColor: Colors.green)
                : createBoxDecorationWithShadows(),
        child: ListTile(
          leading: Icon(
            Icons.payment,
            size: 30.0,
            color:
                paymentMethod.isMainPaymentMethod ? Colors.white : Colors.black,
          ),
          trailing:
              paymentMethod.isMainPaymentMethod
                  ? const Icon(Icons.check, color: Colors.white, size: 35.0)
                  : const Text(''),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerText(
                text: CheckoutHelper.obfuscateCardNumber(
                  paymentMethod.cardNumber,
                ),
                fontsize: 18.0,
                textAling: TextAlign.start,
                color:
                    paymentMethod.isMainPaymentMethod
                        ? Colors.white
                        : Colors.black,
              ),
              headerText(
                text: paymentMethod.monthAndYear,
                fontsize: 16.0,
                color:
                    paymentMethod.isMainPaymentMethod
                        ? Colors.white
                        : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetContent(
    BuildContext context, {
    required PaymentMethodEntity paymentMethod,
  }) {
    return Container(
      height: getScreenHeight(context: context, multiplier: 0.3),
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
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: headerText(
                    text: CheckoutHelper.obfuscateCardNumber(
                      paymentMethod.cardNumber,
                    ),
                    fontsize: 18.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    top: 0.0,
                    right: 20.0,
                    bottom: 10.0,
                  ),
                  child: headerText(
                    text: "Vence: ${paymentMethod.monthAndYear}",
                    fontsize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          if (!paymentMethod.isMainPaymentMethod)
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Usar como tarjeta predeterminada.'),
              onTap: () {
                _selectMainPaymentMethod(paymentMethod);
              },
            ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Eliminar tarjeta'),
            onTap: () {
              _showAlertDeletePaymentMethod(context, paymentMethod);
            },
          ),
        ],
      ),
    );
  }

  Widget _buttonAddCardCredit(
    BuildContext context, {
    PaymentMethodEntity? paymentMethod,
    BaseViewStateDelegate? delegate,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
      child: createElevatedButton(
        onPressed: () {
          coordinator.showAddCardPage(
            context: context,
            paymentMethod: paymentMethod,
            viewStateDelegate: delegate,
          );
        },
        height: 45,
        labelButton: 'Agregar tarjeta',
      ),
    );
  }
}

extension _UserActions on _PaymentMethodsContentViewState {
  _selectMainPaymentMethod(PaymentMethodEntity paymentMethod) {
    (context)
        .selectMainPaymentMethod(paymentMethod: paymentMethod)
        .then((_) => _pop(context));
  }

  _deletePaymentMethod(
    BuildContext context,
    PaymentMethodEntity paymentMethod,
  ) {
    (context).deletePaymentMethod(paymentMethod: paymentMethod).then((_) {
      _pop(context);
      Navigator.pop(context);
    });
  }

  _showAlertDeletePaymentMethod(
    BuildContext context,
    PaymentMethodEntity paymentMethod,
  ) {
    AlertView.showAlertDialog(
      context: context,
      headerTitle: "¿Quierés eliminar esta tarjeta?",
      headerSubTitle: "",
      labelButton: "Eliminar tarjeta",
      backgroundColorButton: Colors.red,
      isDismissible: true,
      cancelText: "Cancelar",
      cancelAction: () => AlertView.closeAlertDialog(context),
      doneButtonFunc: () {
        _deletePaymentMethod(context, paymentMethod);
      },
    );
  }
}
