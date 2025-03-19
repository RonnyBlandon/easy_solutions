import 'dart:convert';

import 'package:easy_solutions/src/utils/Helpers/Checkout/checkout_helper.dart';

class PaymentMethodListBodyParameters {
  final List<PaymentMethodBodyParameters> paymentMethods;

  PaymentMethodListBodyParameters({required this.paymentMethods});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "payment_method_list": List<dynamic>.from(
      paymentMethods.map((x) => x.toMap()),
    ),
  };

  factory PaymentMethodListBodyParameters.fromMap(Map<String, dynamic> json) =>
      PaymentMethodListBodyParameters(
        paymentMethods:
            json["payment_method_list"] == null
                ? []
                : List<PaymentMethodBodyParameters>.from(
                  (json["payment_method_list"] as List<dynamic>).map(
                    (x) => PaymentMethodBodyParameters.fromMap(x),
                  ),
                ),
      );

  static PaymentMethodListBodyParameters getEmptyPaymentMethods() {
    return PaymentMethodListBodyParameters(paymentMethods: []);
  }
}

class PaymentMethodBodyParameters {
  final String nameInTheCard;
  final String cardNumber;
  final String monthAndYear;
  final String cvc;
  final String? cardProvider;
  final String id;
  final String cardAlias;
  final bool isMainPaymentMethod;

  PaymentMethodBodyParameters({
    required this.nameInTheCard,
    required this.cardNumber,
    required this.monthAndYear,
    required this.cvc,
    required this.cardProvider,
    required this.id,
    required this.cardAlias,
    required this.isMainPaymentMethod,
  });

  factory PaymentMethodBodyParameters.fromMap(Map<String, dynamic> json) {
    return PaymentMethodBodyParameters(
      nameInTheCard: json['name_in_the_card'],
      cardNumber: json['card_number'],
      monthAndYear: json['month_and_year'],
      cvc: json['cvc'],
      cardProvider: json['card_provider'],
      id: json['id'],
      cardAlias: json['card_alias'],
      isMainPaymentMethod: json['is_main_payment_method'],
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'name_in_the_card': nameInTheCard,
      'card_number': cardNumber,
      'month_and_year': monthAndYear,
      'cvc': cvc,
      'card_provider': cardProvider,
      'id': id,
      'card_alias': cardAlias,
      'is_main_payment_method': isMainPaymentMethod,
    };
  }
}
