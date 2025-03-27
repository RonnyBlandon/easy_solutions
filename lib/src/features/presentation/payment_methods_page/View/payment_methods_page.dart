import 'package:easy_solutions/src/base/Views/base_view.dart';
import 'package:easy_solutions/src/features/Domain/Entities/PaymentMethods/payment_methods_entity.dart';
import 'package:easy_solutions/src/features/presentation/StateProviders/user_state_provider.dart';
import 'package:easy_solutions/src/features/presentation/error_view/error_view.dart';
import 'package:easy_solutions/src/features/presentation/payment_methods_page/View/components/payment_methods_content_view.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
//Components
import 'package:easy_solutions/src/features/presentation/payment_methods_page/View/components/empty_payment_methods_view.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage>
    with BaseView, BaseViewStateDelegate {
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
      body: FutureBuilder(
        future: (context).getPaymentMethods(),
        builder: (
          BuildContext context,
          AsyncSnapshot<PaymentMethodListEntity?> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return loadingView;
            case ConnectionState.done:
              if (snapshot.hasData && snapshot.data != null) {
                return snapshot.data!.paymentMethods.isNotEmpty
                    ? PaymentMethodsContentView(
                      paymentMethodList: snapshot.data!.paymentMethods,
                      delegate: this,
                    )
                    : EmptyPaymentMethodsView(delegate: this);
              } else {
                return ErrorView(
                  onButtonPressed: () {
                    Navigator.pop(context);
                  },
                );
              }
            default:
              return loadingView;
          }
        },
      ),
    );
  }

  @override
  void onChange() {
    print("+++++++++ onChange");
    setState(() {});
  }
}
