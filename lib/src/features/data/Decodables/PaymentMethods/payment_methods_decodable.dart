import 'dart:convert';

class PaymentMethodListDecodable {
  final List<PaymentMethodDecodable> paymentMethods;

  PaymentMethodListDecodable({required this.paymentMethods});

  factory PaymentMethodListDecodable.fromJson(String str) =>
      PaymentMethodListDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "payment_method_list": List<dynamic>.from(
      paymentMethods.map((x) => x.toMap()),
    ),
  };

  factory PaymentMethodListDecodable.fromMap(Map<String, dynamic> json) =>
      PaymentMethodListDecodable(
        paymentMethods:
            json["payment_method_list"] == null
                ? []
                : List<PaymentMethodDecodable>.from(
                  (json["payment_method_list"] as List<dynamic>).map(
                    (x) => PaymentMethodDecodable.fromMap(x),
                  ),
                ),
      );

  static PaymentMethodListDecodable getEmptyPaymentMethods() {
    return PaymentMethodListDecodable(paymentMethods: []);
  }
}

class PaymentMethodDecodable {
  final String nameInTheCard;
  final String cardNumber;
  final String monthAndYear;
  final String cvc;
  final String? cardProvider;
  final String id;
  final String cardAlias;
  final bool isMainPaymentMethod;

  PaymentMethodDecodable({
    required this.nameInTheCard,
    required this.cardNumber,
    required this.monthAndYear,
    required this.cvc,
    required this.cardProvider,
    required this.id,
    required this.cardAlias,
    required this.isMainPaymentMethod,
  });

  factory PaymentMethodDecodable.fromJson(String str) =>
      PaymentMethodDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentMethodDecodable.fromMap(Map<String, dynamic> json) {
    return PaymentMethodDecodable(
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
