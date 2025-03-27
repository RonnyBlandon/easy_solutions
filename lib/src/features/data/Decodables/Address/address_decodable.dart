import 'dart:convert';

class AddressListDecodable {
  final List<AddressDecodable> addressList;

  AddressListDecodable({required this.addressList});

  factory AddressListDecodable.fromJson(String str) =>
      AddressListDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "address_list": List<dynamic>.from(addressList.map((x) => x.toMap())),
  };

  factory AddressListDecodable.fromMap(Map<String, dynamic> json) =>
      AddressListDecodable(
        addressList:
            json["address_list"] == null
                ? []
                : List<AddressDecodable>.from(
                  (json["address_list"] as List<dynamic>).map(
                    (x) => AddressDecodable.fromMap(x),
                  ),
                ),
      );

  static AddressListDecodable getEmptyAddressList() {
    return AddressListDecodable(addressList: []);
  }
}

class AddressDecodable {
  int id;
  String alias;
  String address;
  String reference;
  String sector;
  double latitude;
  double longitude;
  bool isMainAddress;
  int municipalityId;
  Municipality? municipality;

  AddressDecodable({
    required this.id,
    required this.alias,
    required this.address,
    required this.reference,
    required this.sector,
    required this.latitude,
    required this.longitude,
    required this.isMainAddress,
    required this.municipalityId,
    required this.municipality,
  });

  factory AddressDecodable.fromJson(String str) =>
      AddressDecodable.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressDecodable.fromMap(Map<String, dynamic> json) =>
      AddressDecodable(
        id: json["id"],
        alias: json["alias"],
        address: json["address"],
        reference: json["reference"],
        sector: json["sector"],
        latitude: double.parse(json["latitude"].toString()),
        longitude: double.parse(json["longitude"].toString()),
        isMainAddress: json["is_main_address"],
        municipalityId: json["municipality_id"],
        municipality:
            json["municipality"] == null
                ? null
                : Municipality.fromMap(json["municipality"]),
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "alias": alias,
    "address": address,
    "reference": reference,
    "sector": sector,
    "latitude": latitude,
    "longitude": longitude,
    "is_main_address": isMainAddress,
    "municipality_id": municipalityId,
    "municipality": municipality?.toMap(),
  };
}

class Municipality {
  final int? id;
  final String? name;
  final int? departmentId;

  Municipality({this.id, this.name, this.departmentId});

  factory Municipality.fromJson(String str) =>
      Municipality.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Municipality.fromMap(Map<String, dynamic> json) => Municipality(
    id: json["id"],
    name: json["name"],
    departmentId: json["department_id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "department_id": departmentId,
  };

  static Municipality getEmptyMunicipality() {
    return Municipality();
  }
}
