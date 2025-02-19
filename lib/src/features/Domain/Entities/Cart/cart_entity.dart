import 'dart:convert';
import 'package:easy_solutions/src/features/Domain/Entities/Products/product_entity.dart';

class CartsListEntity {
  final List<CartEntity>? carts;

  CartsListEntity({
    required this.carts,
  });

  factory CartsListEntity.fromJson(String str) =>
      CartsListEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartsListEntity.fromMap(Map<String, dynamic> json) => CartsListEntity(
        carts: List<CartEntity>.from(
            json["business_categories"].map((x) => CartEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "business_categories": List<dynamic>.from(carts!.map((x) => x.toMap())),
      };
}

class CartEntity {
  final String userId;
  final String businessId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String subtotal;
  final String discountTotal;
  final String taxes;
  final String deliveryFee;
  final String total;
  final int id;
  final List<CartItemEntity> cartItems;

  CartEntity({
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

  factory CartEntity.fromJson(String str) =>
      CartEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartEntity.fromMap(Map<String, dynamic> json) => CartEntity(
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
        cartItems: List<CartItemEntity>.from(
            json["cart_items"].map((x) => CartItemEntity.fromMap(x))),
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

class CartItemEntity {
  final String productId;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final ProductDetailEntity product;

  CartItemEntity({
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.product,
  });

  factory CartItemEntity.fromJson(String str) =>
      CartItemEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CartItemEntity.fromMap(Map<String, dynamic> json) => CartItemEntity(
        productId: json["product_id"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        id: json["id"],
        product: ProductDetailEntity.fromMap(json["product"]),
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
