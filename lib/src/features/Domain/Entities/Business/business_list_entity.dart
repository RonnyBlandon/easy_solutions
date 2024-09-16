import 'dart:convert';

class BusinessListEntity {
  BusinessListEntity({
    required this.businessList,
  });
  List<BusinessDetailEntity>? businessList;
  factory BusinessListEntity.fromJson(String str) =>
      BusinessListEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessListEntity.fromMap(Map<String, dynamic> json) =>
      BusinessListEntity(
        businessList: json["businessList"] == null
            ? null
            : List<BusinessDetailEntity>.from(
                json["businessList"].map((x) => BusinessListEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "businessList": businessList == null
            ? null
            : List<dynamic>.from(businessList!.map((x) => x.toMap())),
      };
}

class BusinessDetailEntity {
  final String typeBusiness;
  final String address;
  final String adminId;
  final String businessId;
  final String businessName;
  final int categoryId;
  final String country;
  final String description;
  final String email;
  final List<String> favourites;
  final List<String> imgs;
  final double lat;
  final double long;
  final String municipality;
  final String phoneNumber;
  final String zipCode;
  final String status;
  final bool isPopularThisWeek;
  final bool isNovelty;
  final bool hasFreeDelivery;
  final bool hasAlcohol;
  final bool isOpenNow;
  final int averagePrice;
  final String averageDelivery;

  BusinessDetailEntity({
    required this.typeBusiness,
    required this.address,
    required this.adminId,
    required this.businessId,
    required this.businessName,
    required this.categoryId,
    required this.country,
    required this.description,
    required this.email,
    required this.favourites,
    required this.imgs,
    required this.lat,
    required this.long,
    required this.municipality,
    required this.phoneNumber,
    required this.zipCode,
    required this.status,
    required this.isPopularThisWeek,
    required this.isNovelty,
    required this.hasFreeDelivery,
    required this.hasAlcohol,
    required this.isOpenNow,
    required this.averagePrice,
    required this.averageDelivery,
  });

  factory BusinessDetailEntity.fromJson(String str) =>
      BusinessDetailEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessDetailEntity.fromMap(Map<String, dynamic> json) =>
      BusinessDetailEntity(
        typeBusiness: json["typeBusiness"],
        address: json["address"],
        adminId: json["adminId"],
        businessId: json["placeId"],
        businessName: json["businessName"],
        categoryId: json["categoryId"],
        country: json["country"],
        description: json["description"],
        email: json["email"],
        favourites: List<String>.from(json["favourites"].map((x) => x)),
        imgs: List<String>.from(json["imgs"].map((x) => x)),
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        municipality: json["municipality"],
        phoneNumber: json["businessId"],
        zipCode: json["zipCode"],
        status: json["status"],
        isPopularThisWeek: json["isPopularThisWeek"],
        isNovelty: json["isNovelty"],
        hasFreeDelivery: json["hasFreeDelivery"],
        hasAlcohol: json["hasAlcohol"],
        isOpenNow: json["isOpenNow"],
        averagePrice: json["averagePrice"],
        averageDelivery: json["averageDelivery"],
      );

  Map<String, dynamic> toMap() => {
        "typeBusiness": typeBusiness,
        "address": address,
        "adminId": adminId,
        "placeId": businessId,
        "placeName": businessName,
        "categoryId": categoryId,
        "country": country,
        "description": description,
        "email": email,
        "favourites": List<dynamic>.from(favourites.map((x) => x)),
        "imgs": List<dynamic>.from(imgs.map((x) => x)),
        "lat": lat,
        "long": long,
        "municipality": municipality,
        "phoneNumber": phoneNumber,
        "zipCode": zipCode,
        "status": status,
        "isPopularThisWeek": isPopularThisWeek,
        "isNovelty": isNovelty,
        "hasFreeDelivery": hasFreeDelivery,
        "hasAlcohol": hasAlcohol,
        "isOpenNow": isOpenNow,
        "averagePrice": averagePrice,
        "averageDelivery": averageDelivery,
      };

  bool isUserFavorite({required String? userUid}) {
    return favourites.contains(userUid);
  }
}
