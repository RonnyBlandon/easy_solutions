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
            : List<BusinessDetailEntity>.from(json["businessList"]
                .map((x) => BusinessDetailEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "businessList": businessList == null
            ? null
            : List<dynamic>.from(businessList!.map((x) => x.toMap())),
      };
}

class BusinessDetailEntity {
  final String address;
  final String adminId;
  final String businessName;
  final int municipalityId;
  final String country;
  final String description;
  final String email;
  final double lat;
  final double long;
  final String phoneNumber;
  final String zipCode;
  final bool isActive;
  final bool isPopularThisWeek;
  final bool isNovelty;
  final bool hasFreeDelivery;
  final bool hasAlcohol;
  final bool isOpenNow;
  final double averagePrice;
  final String averageDelivery;
  final String id;
  final TypeBusinessDetailEntity typeBusiness;
  final List<BusinessImageEntity> businessImages;

  BusinessDetailEntity({
    required this.address,
    required this.adminId,
    required this.businessName,
    required this.municipalityId,
    required this.country,
    required this.description,
    required this.email,
    required this.lat,
    required this.long,
    required this.phoneNumber,
    required this.zipCode,
    required this.isActive,
    required this.isPopularThisWeek,
    required this.isNovelty,
    required this.hasFreeDelivery,
    required this.hasAlcohol,
    required this.isOpenNow,
    required this.averagePrice,
    required this.averageDelivery,
    required this.id,
    required this.typeBusiness,
    required this.businessImages,
  });

  factory BusinessDetailEntity.fromJson(String str) =>
      BusinessDetailEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessDetailEntity.fromMap(Map<String, dynamic> json) =>
      BusinessDetailEntity(
        address: json["address"],
        adminId: json["admin_id"],
        businessName: json["business_name"],
        municipalityId: json["municipality_id"],
        country: json["country"],
        description: json["description"],
        email: json["email"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        phoneNumber: json["phone_number"],
        zipCode: json["zip_code"],
        isActive: json["is_active"],
        isPopularThisWeek: json["is_popular_this_week"],
        isNovelty: json["is_novelty"],
        hasFreeDelivery: json["has_free_delivery"],
        hasAlcohol: json["has_alcohol"],
        isOpenNow: json["is_open_now"],
        averagePrice: json["average_price"]?.toDouble(),
        averageDelivery: json["average_delivery"],
        id: json["id"],
        typeBusiness: TypeBusinessDetailEntity.fromMap(json["type_business"]),
        businessImages: List<BusinessImageEntity>.from(
            json["business_images"].map((x) => BusinessImageEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "admin_id": adminId,
        "business_name": businessName,
        "municipality_id": municipalityId,
        "country": country,
        "description": description,
        "email": email,
        "lat": lat,
        "long": long,
        "phone_number": phoneNumber,
        "zip_code": zipCode,
        "is_active": isActive,
        "is_popular_this_week": isPopularThisWeek,
        "is_novelty": isNovelty,
        "has_free_delivery": hasFreeDelivery,
        "has_alcohol": hasAlcohol,
        "is_open_now": isOpenNow,
        "average_price": averagePrice,
        "average_delivery": averageDelivery,
        "id": id,
        "type_business": typeBusiness.toMap(),
        "business_images":
            List<dynamic>.from(businessImages.map((x) => x.toMap())),
      };
}

class BusinessImageEntity {
  final String imageUrl;
  final String imageType;
  final int id;

  BusinessImageEntity({
    required this.imageUrl,
    required this.imageType,
    required this.id,
  });

  factory BusinessImageEntity.fromJson(String str) =>
      BusinessImageEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessImageEntity.fromMap(Map<String, dynamic> json) =>
      BusinessImageEntity(
        imageUrl: json["image_url"],
        imageType: json["image_type"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "image_url": imageUrl,
        "image_type": imageType,
        "id": id,
      };
}

class TypeBusinessListEntity {
  TypeBusinessListEntity({
    required this.typeBusinessList,
  });
  List<TypeBusinessDetailEntity>? typeBusinessList;
  factory TypeBusinessListEntity.fromJson(String str) =>
      TypeBusinessListEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeBusinessListEntity.fromMap(Map<String, dynamic> json) =>
      TypeBusinessListEntity(
        typeBusinessList: json["type_business_list"] == null
            ? null
            : List<TypeBusinessDetailEntity>.from(json["type_business_list"]
                .map((x) => TypeBusinessDetailEntity.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "type_business_list": typeBusinessList == null
            ? null
            : List<dynamic>.from(typeBusinessList!.map((x) => x.toMap())),
      };
}

class TypeBusinessDetailEntity {
  final String name;
  final String imageUrl;
  final int id;

  TypeBusinessDetailEntity({
    required this.name,
    required this.imageUrl,
    required this.id,
  });

  factory TypeBusinessDetailEntity.fromJson(String str) =>
      TypeBusinessDetailEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeBusinessDetailEntity.fromMap(Map<String, dynamic> json) =>
      TypeBusinessDetailEntity(
        name: json["name"],
        imageUrl: json["image_url"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "image_url": imageUrl,
        "id": id,
      };
}
