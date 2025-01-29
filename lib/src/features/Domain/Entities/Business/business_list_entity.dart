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
  final bool status;
  final bool isPopularThisWeek;
  final bool isNovelty;
  final bool hasFreeDelivery;
  final bool hasAlcohol;
  final bool isOpenNow;
  final double averagePrice;
  final String averageDelivery;
  final String id;
  final TypeBusiness typeBusiness;
  final List<BusinessImage> images;

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
    required this.status,
    required this.isPopularThisWeek,
    required this.isNovelty,
    required this.hasFreeDelivery,
    required this.hasAlcohol,
    required this.isOpenNow,
    required this.averagePrice,
    required this.averageDelivery,
    required this.id,
    required this.typeBusiness,
    required this.images,
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
        status: json["status"],
        isPopularThisWeek: json["is_popular_this_week"],
        isNovelty: json["is_novelty"],
        hasFreeDelivery: json["has_free_delivery"],
        hasAlcohol: json["has_alcohol"],
        isOpenNow: json["is_open_now"],
        averagePrice: json["average_price"]?.toDouble(),
        averageDelivery: json["average_delivery"],
        id: json["id"],
        typeBusiness: TypeBusiness.fromMap(json["type_business"]),
        images: List<BusinessImage>.from(
            json["images"].map((x) => BusinessImage.fromMap(x))),
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
        "status": status,
        "is_popular_this_week": isPopularThisWeek,
        "is_novelty": isNovelty,
        "has_free_delivery": hasFreeDelivery,
        "has_alcohol": hasAlcohol,
        "is_open_now": isOpenNow,
        "average_price": averagePrice,
        "average_delivery": averageDelivery,
        "id": id,
        "type_business": typeBusiness.toMap(),
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
      };
}

class BusinessImage {
  final String imageUrl;
  final String imageType;
  final String id;

  BusinessImage({
    required this.imageUrl,
    required this.imageType,
    required this.id,
  });

  factory BusinessImage.fromJson(String str) =>
      BusinessImage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessImage.fromMap(Map<String, dynamic> json) => BusinessImage(
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

class TypeBusiness {
  final String name;
  final int id;

  TypeBusiness({
    required this.name,
    required this.id,
  });

  factory TypeBusiness.fromJson(String str) =>
      TypeBusiness.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeBusiness.fromMap(Map<String, dynamic> json) => TypeBusiness(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "id": id,
      };
}
