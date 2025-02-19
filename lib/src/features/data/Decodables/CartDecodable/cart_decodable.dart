import 'dart:convert';

import 'package:easy_solutions/src/features/data/Decodables/ProductDecodable/products_decodable.dart';

class CartsListDecodable {
  final List<CartDecodable>? carts;

  CartsListDecodable({
    required this.carts,
  });

  factory CartsListDecodable.fromJson(String str) =>
      CartsListDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartsListDecodable.fromMap(Map<String, dynamic> json) =>
      CartsListDecodable(
        carts: List<CartDecodable>.from(
            json["business_categories"].map((x) => CartDecodable.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "business_categories": List<dynamic>.from(carts!.map((x) => x.toMap())),
      };
}

class CartDecodable {
  final String? userId;
  final String? businessId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? subtotal;
  final String? discountTotal;
  final String? taxes;
  final String? deliveryFee;
  final String? total;
  final int? id;
  final List<CartItemDecodable> cartItems;

  CartDecodable({
    required this.userId,
    required this.businessId,
    required this.createdAt,
    required this.updatedAt,
    required this.subtotal,
    required this.discountTotal,
    required this.taxes,
    required this.deliveryFee,
    required this.total,
    required this.id,
    required this.cartItems,
  });

  factory CartDecodable.fromJson(String str) =>
      CartDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartDecodable.fromMap(Map<String, dynamic> json) => CartDecodable(
        userId: json["user_id"],
        businessId: json["business_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subtotal: json["subtotal"],
        discountTotal: json["discount_total"],
        taxes: json["taxes"],
        deliveryFee: json["delivery_fee"],
        total: json["total"],
        id: json["id"],
        cartItems: List<CartItemDecodable>.from(
            json["cart_items"].map((x) => CartItemDecodable.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "business_id": businessId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "subtotal": subtotal,
        "discount_total": discountTotal,
        "taxes": taxes,
        "delivery_fee": deliveryFee,
        "total": total,
        "id": id,
        "cart_items": List<dynamic>.from(cartItems.map((x) => x.toMap())),
      };
}

class CartItemDecodable {
  final String productId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final ProductDetailDecodable product;

  CartItemDecodable({
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.product,
  });

  factory CartItemDecodable.fromJson(String str) =>
      CartItemDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartItemDecodable.fromMap(Map<String, dynamic> json) =>
      CartItemDecodable(
        productId: json["product_id"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        id: json["id"],
        product: ProductDetailDecodable.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id": id,
        "product": product.toMap(),
      };
}
