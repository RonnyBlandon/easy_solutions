import 'dart:convert';

class FavoritesListEntity {
  FavoritesListEntity({
    required this.favoritesList,
  });

  final List<FavoriteEntity>? favoritesList;

  factory FavoritesListEntity.fromJson(String str) =>
      FavoritesListEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoritesListEntity.fromMap(Map<String, dynamic> json) =>
      FavoritesListEntity(
        favoritesList: json["favorites_list"] == null
            ? []
            : List<FavoriteEntity>.from(
                (json["favorites_list"] as List<dynamic>).map(
                  (x) => FavoriteEntity.fromMap(x),
                ),
              ),
      );

  Map<String, dynamic> toMap() => {
        "favorites_list": List<dynamic>.from(favoritesList!.map((x) => x.toMap())),
      };
}

class FavoriteEntity {
    final String? userId;
    final String? businessId;
    final String? productId;
    final int? id;

    FavoriteEntity({
        this.userId,
        this.businessId,
        this.productId,
        this.id,
    });

    factory FavoriteEntity.fromJson(String str) => FavoriteEntity.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FavoriteEntity.fromMap(Map<String, dynamic> json) => FavoriteEntity(
        userId: json["user_id"],
        businessId: json["business_id"],
        productId: json["product_id"],
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "user_id": userId,
        "business_id": businessId,
        "product_id": productId,
        "id": id,
    };
}