import 'dart:convert';

class BusinessListDecodable {
  BusinessListDecodable({
    required this.businessList,
  });
  List<BusinessDetailDecodable>? businessList;
  factory BusinessListDecodable.fromJson(String str) =>
      BusinessListDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessListDecodable.fromMap(Map<String, dynamic> json) =>
      BusinessListDecodable(
        businessList: json["business_list"] == null
            ? null
            : List<BusinessDetailDecodable>.from(json["business_list"]
                .map((x) => BusinessDetailDecodable.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "business_list": businessList == null
            ? null
            : List<dynamic>.from(businessList!.map((x) => x.toMap())),
      };
}

class BusinessDetailDecodable {
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
  bool? isFavorite;
  final TypeBusinessDetailDecodable typeBusiness;
  final List<BusinessImage> businessImages;

  BusinessDetailDecodable({
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
    required this.isFavorite,
    required this.typeBusiness,
    required this.businessImages,
  });

  factory BusinessDetailDecodable.fromJson(String str) =>
      BusinessDetailDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessDetailDecodable.fromMap(Map<String, dynamic> json) =>
      BusinessDetailDecodable(
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
        isFavorite: json["is_favorite"],
        typeBusiness:
            TypeBusinessDetailDecodable.fromMap(json["type_business"]),
        
        businessImages: List<BusinessImage>.from(
            json["business_images"].map((x) => BusinessImage.fromMap(x))),
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
        "is_favorite": isFavorite,
        "type_business": typeBusiness.toMap(),
        "business_images":
            List<dynamic>.from(businessImages.map((x) => x.toMap())),
      };
}

class BusinessImage {
  final String imageUrl;
  final String imageType;
  final int id;

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

class TypeBusinessListDecodable {
  TypeBusinessListDecodable({
    required this.typeBusinessList,
  });
  List<TypeBusinessDetailDecodable>? typeBusinessList;
  factory TypeBusinessListDecodable.fromJson(String str) =>
      TypeBusinessListDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeBusinessListDecodable.fromMap(Map<String, dynamic> json) =>
      TypeBusinessListDecodable(
        typeBusinessList: json["type_business_list"] == null
            ? null
            : List<TypeBusinessDetailDecodable>.from(json["type_business_list"]
                .map((x) => TypeBusinessDetailDecodable.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "type_business_list": typeBusinessList == null
            ? null
            : List<dynamic>.from(typeBusinessList!.map((x) => x.toMap())),
      };
}

class TypeBusinessDetailDecodable {
  final String name;
  final String imageUrl;
  final int id;

  TypeBusinessDetailDecodable({
    required this.name,
    required this.imageUrl,
    required this.id,
  });

  factory TypeBusinessDetailDecodable.fromJson(String str) =>
      TypeBusinessDetailDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TypeBusinessDetailDecodable.fromMap(Map<String, dynamic> json) =>
      TypeBusinessDetailDecodable(
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
