import 'dart:convert';

class FavoritesListDecodable {
  FavoritesListDecodable({
    required this.favoritesList,
  });

  final List<FavoriteDecodable>? favoritesList;

  factory FavoritesListDecodable.fromJson(String str) =>
      FavoritesListDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoritesListDecodable.fromMap(Map<String, dynamic> json) =>
      FavoritesListDecodable(
        favoritesList: json["favorites_list"] == null
            ? []
            : List<FavoriteDecodable>.from(
                (json["favorites_list"] as List<dynamic>).map(
                  (x) => FavoriteDecodable.fromMap(x),
                ),
              ),
      );

  Map<String, dynamic> toMap() => {
        "favorites_list": List<dynamic>.from(favoritesList!.map((x) => x.toMap())),
      };
}

class FavoriteDecodable {
    final String? userId;
    final String? businessId;
    final String? productId;
    final int? id;

    FavoriteDecodable({
        this.userId,
        this.businessId,
        this.productId,
        this.id,
    });

    factory FavoriteDecodable.fromJson(String str) => FavoriteDecodable.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FavoriteDecodable.fromMap(Map<String, dynamic> json) => FavoriteDecodable(
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
