import 'dart:convert';
import 'package:easy_solutions/src/features/data/Repositories/PaymentMethods/BodyParameters/payment_methods_body_parameters.dart';

class PaymentMethodListEntity {
  List<PaymentMethodEntity> paymentMethods;

  PaymentMethodListEntity({required this.paymentMethods});

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "payment_method_list": List<dynamic>.from(
      paymentMethods.map((x) => x.toMap()),
    ),
  };

  factory PaymentMethodListEntity.fromMap(Map<String, dynamic> json) =>
      PaymentMethodListEntity(
        paymentMethods:
            json["payment_method_list"] == null
                ? []
                : List<PaymentMethodEntity>.from(
                  (json["payment_method_list"] as List<dynamic>).map(
                    (x) => PaymentMethodEntity.fromMap(x),
                  ),
                ),
      );

  static PaymentMethodListEntity getEmptyPaymentMethods() {
    return PaymentMethodListEntity(paymentMethods: []);
  }

  PaymentMethodListBodyParameters getPaymentMethodListBodyParameters() {
    return PaymentMethodListBodyParameters.fromMap(toMap());
  }

  bool hasPaymentMethods() {
    return paymentMethods.isNotEmpty;
  }
}

class PaymentMethodEntity {
  String nameInTheCard;
  String cardNumber;
  String monthAndYear;
  String cvc;
  String? cardProvider;
  String id;
  String cardAlias;
  bool isMainPaymentMethod;

  PaymentMethodEntity({
    required this.nameInTheCard,
    required this.cardNumber,
    required this.monthAndYear,
    required this.cvc,
    required this.cardProvider,
    required this.id,
    required this.cardAlias,
    required this.isMainPaymentMethod,
  });

  factory PaymentMethodEntity.fromMap(Map<String, dynamic> json) {
    return PaymentMethodEntity(
      nameInTheCard: json['name_in_the_card'],
      cardNumber: json['card_number'],
      monthAndYear: json['month_and_year'],
      cvc: json['cvc'],
      cardProvider: json['card_provider'],
      id: json['id'],
      cardAlias: json['card_alias'],
      isMainPaymentMethod: json['is_main_payment_method'] ?? false,
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

  static PaymentMethodEntity getEmptyPaymentMethod() {
    return PaymentMethodEntity(
      nameInTheCard: '',
      cardNumber: '',
      monthAndYear: '',
      cvc: '',
      cardProvider: '',
      id: '',
      cardAlias: '',
      isMainPaymentMethod: false,
    );
  }

  PaymentMethodBodyParameters getPaymentMethodBodyParameters() {
    return PaymentMethodBodyParameters.fromMap(toMap());
  }
}
