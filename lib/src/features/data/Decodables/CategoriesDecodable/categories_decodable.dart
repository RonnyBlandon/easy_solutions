import 'dart:convert';

class CategoriesDecodable {
  CategoriesDecodable({
    required this.collections,
  });

  final List<Category>? collections;

  factory CategoriesDecodable.fromJson(String str) =>
      CategoriesDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesDecodable.fromMap(Map<String, dynamic> json) =>
      CategoriesDecodable(
        collections: json["collections"] == null
            ? null
            : List<Category>.from(
                json["collections"].map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "collections": collections == null
            ? null
            : List<dynamic>.from(collections!.map((x) => x.toMap())),
      };
}

class Category {
  final int id;
  final String img;
  final String name;

  Category({
    required this.id,
    required this.img,
    required this.name,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
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
