import 'dart:convert';
import 'package:easy_solutions/src/features/Domain/Entities/Business/business_list_entity.dart';
import 'package:easy_solutions/src/features/Domain/Entities/Products/product_entity.dart';

class BusinessCategoryListEntity {
  final BusinessDetailEntity business;
  final List<BusinessCategoryEntity>? businessCategories;

  BusinessCategoryListEntity({
    required this.business,
    required this.businessCategories,
  });

  factory BusinessCategoryListEntity.fromJson(String str) =>
      BusinessCategoryListEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessCategoryListEntity.fromMap(Map<String, dynamic> json) =>
      BusinessCategoryListEntity(
        business: BusinessDetailEntity.fromMap(json["business"]),
        businessCategories: List<BusinessCategoryEntity>.from(
            json["business_categories"]
                .map((x) => BusinessCategoryEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "business": business.toMap(),
        "business_categories":
            List<dynamic>.from(businessCategories!.map((x) => x.toMap())),
      };

  /// Método para filtrar categorías sin productos
  BusinessCategoryListEntity filterCategoriesByProductList() {
    return BusinessCategoryListEntity(
      business: business,
      businessCategories: businessCategories
          ?.where((category) => category.products.isNotEmpty)
          .toList(),
    );
  }
}

class BusinessCategoryEntity {
  final String name;
  final String businessId;
  final int id;
  final List<ProductDetailEntity> products;

  BusinessCategoryEntity({
    required this.name,
    required this.businessId,
    required this.id,
    required this.products,
  });

  factory BusinessCategoryEntity.fromJson(String str) =>
      BusinessCategoryEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessCategoryEntity.fromMap(Map<String, dynamic> json) =>
      BusinessCategoryEntity(
          name: json["name"],
          businessId: json["business_id"],
          id: json["id"],
          products: List<ProductDetailEntity>.from(
              json["products"].map((x) => ProductDetailEntity.fromMap(x))));

  Map<String, dynamic> toMap() => {
        "name": name,
        "business_id": businessId,
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}
