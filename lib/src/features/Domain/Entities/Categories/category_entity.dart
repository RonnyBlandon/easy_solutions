import 'dart:convert';

class CategoriesEntity {
  CategoriesEntity({
    required this.collections,
  });

  final List<CategoryDetailEntity>? collections;

  factory CategoriesEntity.fromJson(String str) =>
      CategoriesEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesEntity.fromMap(Map<String, dynamic> json) =>
      CategoriesEntity(
        collections: json["collections"] == null
            ? null
            : List<CategoryDetailEntity>.from(json["collections"]
                .map((x) => CategoryDetailEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "collections": collections == null
            ? null
            : List<dynamic>.from(collections!.map((x) => x.toMap())),
      };
}

class CategoryDetailEntity {
  final int id;
  final String img;
  final String name;

  CategoryDetailEntity({
    required this.id,
    required this.img,
    required this.name,
  });

  factory CategoryDetailEntity.fromJson(String str) =>
      CategoryDetailEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryDetailEntity.fromMap(Map<String, dynamic> json) =>
      CategoryDetailEntity(
        id: json["id"],
        img: json["img"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "img": img,
        "name": name,
      };
}
