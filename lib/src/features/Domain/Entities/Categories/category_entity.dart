import 'dart:convert';

class CategoriesEntity {
  CategoriesEntity({
    required this.categories,
  });

  final List<CategoryDetailEntity> categories;

  factory CategoriesEntity.fromJson(String str) =>
      CategoriesEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesEntity.fromMap(Map<String, dynamic> json) =>
      CategoriesEntity(
        categories: json["categories"] == null
            ? []
            : List<CategoryDetailEntity>.from(
                (json["categories"] as List<dynamic>).map(
                  (x) => CategoriesEntity.fromMap(x),
                ),
              ),
      );

  Map<String, dynamic> toMap() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
      };
}

class CategoryDetailEntity {
  final String name;
  final String businessId;
  final int id;
  final List<Product> products;

  CategoryDetailEntity({
    required this.name,
    required this.businessId,
    required this.id,
    required this.products,
  });

  factory CategoryDetailEntity.fromJson(String str) =>
      CategoryDetailEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryDetailEntity.fromMap(Map<String, dynamic> json) =>
      CategoryDetailEntity(
        name: json["name"],
        businessId: json["business_id"],
        id: json["id"],
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "business_id": businessId,
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}

class Product {
  final String name;
  final String price;
  final String description;
  final int stock;
  final bool available;
  final String businessId;
  final String discount;
  final bool isActive;
  final String id;
  final List<Option> options;
  final List<Image> images;
  final List<Category> categories;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.stock,
    required this.available,
    required this.businessId,
    required this.discount,
    required this.isActive,
    required this.id,
    required this.options,
    required this.images,
    required this.categories,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        name: json["name"],
        price: json["price"],
        description: json["description"],
        stock: json["stock"],
        available: json["available"],
        businessId: json["business_id"],
        discount: json["discount"],
        isActive: json["is_active"],
        id: json["id"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
        "description": description,
        "stock": stock,
        "available": available,
        "business_id": businessId,
        "discount": discount,
        "is_active": isActive,
        "id": id,
        "options": List<dynamic>.from(options.map((x) => x.toMap())),
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
        "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
      };
}

class Category {
  final String name;
  final String businessId;

  Category({
    required this.name,
    required this.businessId,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        name: json["name"],
        businessId: json["business_id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "business_id": businessId,
      };
}

class Image {
  final String productId;
  final String imageUrl;
  final dynamic imageType;
  final String id;

  Image({
    required this.productId,
    required this.imageUrl,
    required this.imageType,
    required this.id,
  });

  factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Image.fromMap(Map<String, dynamic> json) => Image(
        productId: json["product_id"],
        imageUrl: json["image_url"],
        imageType: json["image_type"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "product_id": productId,
        "image_url": imageUrl,
        "image_type": imageType,
        "id": id,
      };
}

class Option {
  final String title;
  final int maxExtras;
  final bool isRequired;
  final String productId;
  final String id;
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
  final String optionId;
  final String id;

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
        price: json["price"]?.toDouble(),
        optionId: json["option_id"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "price": price,
        "option_id": optionId,
        "id": id,
      };
}
