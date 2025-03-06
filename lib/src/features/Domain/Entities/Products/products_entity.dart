import 'dart:convert';

class ProductListEntity {
  ProductListEntity({required this.productList});

  final List<ProductDetailEntity>? productList;

  factory ProductListEntity.fromJson(String str) =>
      ProductListEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductListEntity.fromMap(Map<String, dynamic> json) {
    return ProductListEntity(
      productList:
          json["product_list"] == null
              ? []
              : List<ProductDetailEntity>.from(
                (json["product_list"] as List<dynamic>).map(
                  (x) => ProductDetailEntity.fromMap(x),
                ),
              ),
    );
  }
  Map<String, dynamic> toMap() => {
    "categories": List<dynamic>.from(productList!.map((x) => x.toMap())),
  };
}

class ProductDetailEntity {
  final String name;
  final double price;
  final String description;
  final String productImageUrl;
  final int stock;
  final bool available;
  final String businessId;
  final double discount;
  final bool isActive;
  final String id;
  bool? isFavorite;
  final List<Option> options;

  ProductDetailEntity({
    required this.name,
    required this.price,
    required this.description,
    required this.productImageUrl,
    required this.stock,
    required this.available,
    required this.businessId,
    required this.discount,
    required this.isActive,
    required this.id,
    required this.isFavorite,
    required this.options,
  });

  factory ProductDetailEntity.fromJson(String str) =>
      ProductDetailEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailEntity.fromMap(Map<String, dynamic> json) =>
      ProductDetailEntity(
        name: json["name"],
        price: double.parse(json["price"]),
        description: json["description"],
        productImageUrl: json["product_image_url"],
        stock: json["stock"],
        available: json["available"],
        businessId: json["business_id"],
        discount: double.parse(json["discount"]),
        isActive: json["is_active"],
        id: json["id"],
        isFavorite: json["is_favorite"],
        options: List<Option>.from(
          json["options"].map((x) => Option.fromMap(x)),
        ),
      );

  Map<String, dynamic> toMap() => {
    "name": name,
    "price": price.toString(),
    "description": description,
    "product_image_url": productImageUrl,
    "stock": stock,
    "available": available,
    "business_id": businessId,
    "discount": discount.toString(),
    "is_active": isActive,
    "id": id,
    "is_favorite": isFavorite,
    "options": List<dynamic>.from(options.map((x) => x.toMap())),
  };
}

class Option {
  final String title;
  final int maxExtras;
  final bool isRequired;
  final String productId;
  final int id;
  final List<Extra> extras;

  Option({
    required this.title,
    required this.maxExtras,
    required this.isRequired,
    required this.productId,
    required this.id,
    required this.extras,
  });

  factory Option.fromJson(String str) => Option.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Option.fromMap(Map<String, dynamic> json) => Option(
    title: json["title"],
    maxExtras: json["max_extras"],
    isRequired: json["is_required"],
    productId: json["product_id"],
    id: json["id"],
    extras: List<Extra>.from(json["extras"].map((x) => Extra.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "max_extras": maxExtras,
    "is_required": isRequired,
    "product_id": productId,
    "id": id,
    "extras": List<dynamic>.from(extras.map((x) => x.toMap())),
  };
}

class Extra {
  final String title;
  final double price;
  final int optionId;
  final int id;

  Extra({
    required this.title,
    required this.price,
    required this.optionId,
    required this.id,
  });

  factory Extra.fromJson(String str) => Extra.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Extra.fromMap(Map<String, dynamic> json) => Extra(
    title: json["title"],
    price: double.parse(json["price"]),
    optionId: json["option_id"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "price": price.toString(),
    "option_id": optionId,
    "id": id,
  };
}
