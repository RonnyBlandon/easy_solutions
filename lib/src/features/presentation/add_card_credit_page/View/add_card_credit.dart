import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//Colors
import 'package:easy_solutions/src/colors/colors.dart';
//Commons Widgets
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/back_button.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/headers/header_text.dart';
import 'package:easy_solutions/src/features/presentation/commons_widgets/buttons/create_elevated_button.dart';

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
        title: headerText(text: 'Agregar Tarjeta', fontsize: 18.0),
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
                  // Input card number
                  TextFormField(
                    selectionControls: EmptyTextSelectionControls(),
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
                    // Input card Name
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
                          // Input cvv card
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
                          // Input card expiration date
                          child: TextFormField(
                        enableInteractiveSelection: false,
                        keyboardType: TextInputType.number,
                        //Limit the input
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.digitsOnly,
                          ExpiryDateInputFormatter(),
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
                    //Input Card alias
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

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Permitir solo caracteres numéricos
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limitar la longitud del texto a 4 caracteres (MMYY)
    if (newText.length > 4) {
      newText = newText.substring(0, 4);
    }

    // Insertar la barra automáticamente después del segundo dígito
    if (newText.length > 2 && !newText.contains('/')) {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    }

    //Valindando los digitos del mes
    // ignore: prefer_is_empty
    if (newText.length == 1) {
      if (newText[0] != '0' && newText[0] != '1') {
        newText = '0${newText[0]}';
      }
    } else if (newText.length >= 2) {
      if (int.parse(newText[1]) >= 3 &&
          int.parse(newText[1]) <= 9 &&
          newText[0] == '1') {
        newText = '1';
      } else if (newText[0] == '0' && newText[1] == '0') {
        newText = newText.substring(0, 1);
      }
    }
    //Valindando los digitos del año
    int currentYear = DateTime.now().year % 100;
    if (newText.length > 3) {
      String year = newText.substring(3);
      if (year.length == 2 && int.parse(year) < currentYear) {
        newText = newText.substring(0, 3) + currentYear.toString();
      }
    }

    // Construir el texto formateado
    String formattedText = newText;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
