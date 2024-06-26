import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';
import 'package:flutter/material.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/custom_title.dart';
import 'package:flutter/services.dart';

class FormAddCardCredit extends StatefulWidget {
  const FormAddCardCredit({super.key});

  @override
  State<FormAddCardCredit> createState() => _FormAddCardCreditState();
}

class _FormAddCardCreditState extends State<FormAddCardCredit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGreyPage,
      appBar: AppBar(
        leading: backButton(context, black),
        backgroundColor: white,
        title: customTitle('Agregar Tarjeta', Colors.black, fontsize: 18.0),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Image(
                width: 100.0,
                image: AssetImage('assets/images/card_credit.png'),
              ),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardNumberInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                        hintText: 'Número de tarjeta',
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        icon: Icon(
                          Icons.payment,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Nombre en la tarjeta',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          icon: Icon(Icons.person_outline)),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        //Limit the input
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          //Now still our CVV allow other characters
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          hintText: 'CVV',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          icon: Icon(Icons.lock_outlined),
                        ),
                      )),
                      const SizedBox(width: 20.0),
                      Expanded(
                          child: TextFormField(
                        keyboardType: TextInputType.number,
                        //Limit the input
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                            hintText: 'MM/YY',
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            icon: Icon(Icons.calendar_month_outlined)),
                      )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Alias para identificar esta tarjeta.',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          icon: Icon(Icons.payment)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: createElevatedButton(
                        onPressed: () {},
                        labelButton: 'Guardar Tarjeta',
                        backgroundColor: Colors.blue),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  "); // double space
      }
    }

    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(
          offset: buffer.toString().length,
        ));
  }
}
