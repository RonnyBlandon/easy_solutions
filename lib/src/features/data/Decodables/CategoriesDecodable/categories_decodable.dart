import 'dart:convert';

import 'package:easy_solutions/src/features/data/Decodables/ProductDecodable/products_decodable.dart';
import 'package:easy_solutions/src/managers/businessManager/Decodables/business_list_decodable.dart';

class BusinessCategoryListDecodable {
  final BusinessDetailDecodable business;
  final List<BusinessCategoryDecodable> businessCategories;

  BusinessCategoryListDecodable({
    required this.business,
    required this.businessCategories,
  });

  factory BusinessCategoryListDecodable.fromJson(String str) =>
      BusinessCategoryListDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessCategoryListDecodable.fromMap(Map<String, dynamic> json) =>
      BusinessCategoryListDecodable(
        business: BusinessDetailDecodable.fromMap(json["business"]),
        businessCategories: List<BusinessCategoryDecodable>.from(
            json["business_categories"]
                .map((x) => BusinessCategoryDecodable.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "business": business.toMap(),
        "business_categories":
            List<dynamic>.from(businessCategories.map((x) => x.toMap())),
      };
}

class BusinessCategoryDecodable {
  final String name;
  final String businessId;
  final int id;
  final List<ProductDetailDecodable> products;

  BusinessCategoryDecodable({
    required this.name,
    required this.businessId,
    required this.id,
    required this.products,
  });

  factory BusinessCategoryDecodable.fromJson(String str) =>
      BusinessCategoryDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessCategoryDecodable.fromMap(Map<String, dynamic> json) =>
      BusinessCategoryDecodable(
        name: json["name"],
        businessId: json["business_id"],
        id: json["id"],
        products: List<ProductDetailDecodable>.from(
            json["products"].map((x) => ProductDetailDecodable.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "business_id": businessId,
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}
